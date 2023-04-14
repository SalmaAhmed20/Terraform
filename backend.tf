terraform {
  backend "s3" {
    bucket = "saloma-terraform-bucket"
    dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}