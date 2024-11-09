output "server_url" {
  value = google_cloud_run_v2_service.server.uri
}

output "front_url" {
  value = google_cloud_run_v2_service.front.uri
}