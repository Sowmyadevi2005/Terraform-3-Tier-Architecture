terraform {
# Terraform configuration block
  backend "s3" {
# Remote state storage configuration
    bucket  = "dev-3-tier-architecture-tf"
    key     = "terraform/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
