## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/nakai95/maptalk-iac.git
   cd maptalk-iac
   ```
2. Create a `.tfvars` files.

## Terraform Commands

1. Initialize Terraform
   ```bash
   terraform init
   ```
2. Validate Configuration
   ```bash
   terraform validate
   ```
3. Plan the Infrastructure
   ```bash
   terraform plan
   ```
4. Apply the Configuration
   ```bash
   terraform apply
   ```
5. Destroy the Infrastructure
   ```bash
   terraform destroy
   ```

## Directory Structure

```
.
├── main.tf                # Main Terraform configuration
├── variables.tf           # Variable definitions
├── outputs.tf             # Output definitions
├── terraform.tfvars       # Sensitive variable values (do not commit)
└── README.md              # Instructions and documentation
```
