terraform {
  backend "s3" {
    bucket         = "shashi-terraform-state-2026"
    key            = "04-vpc/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}