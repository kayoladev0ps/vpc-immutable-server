# Create s3 bucket
module "s3" {
  source = "../modules/s3"
  region = var.region
  bucket = var.bucket
  project_name = var.project_name
  environment = var.environment
}