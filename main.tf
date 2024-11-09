terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project
}


resource "google_cloud_run_v2_service" "server" {
  name     = "map-talk-service"
  location = "us-central1"
  client   = "terraform"

  template {
    containers {
      image = var.server_image
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
    scaling {
      min_instance_count = 1
      max_instance_count = 1
    }
  }
}

resource "google_cloud_run_v2_service" "front" {
  name     = "map-talk-front"
  location = "us-central1"
  client   = "terraform"

  template {
    containers {
      image = var.front_image
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
      ports {
        container_port = 3000
      }
      env {
        name  = "NEXT_PUBLIC_API_URL"
        value = google_cloud_run_v2_service.server.uri
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "server_noauth" {
  location = google_cloud_run_v2_service.server.location
  name     = google_cloud_run_v2_service.server.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloud_run_v2_service.front.location
  service  = google_cloud_run_v2_service.front.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}
