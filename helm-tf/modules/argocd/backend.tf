terraform {
  backend "s3" {
    encrypt = true
    bucket  = "tf-backend-tikal-task"
    key     = "tf-state-argo-cd/terraform.tfstate"
    region  = "eu-central-1"
  }
}    