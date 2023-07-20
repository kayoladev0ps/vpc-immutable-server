 # store the terraform state file in s3
terraform {
   backend "s3" {
    bucket    = "jknsdockerd042979q"
    key       = "tf-state/april-project"
    region    = "us-east-1"
    profile   = "terraform"
    dynamodb_table ="state-lockDB"
  }
 }

# provider block
provider "aws" {
     region = "us-east-1"
     profile = "terraform"
 }