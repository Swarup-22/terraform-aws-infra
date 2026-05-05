terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-terraform-aws-infra"
    key            = "dev/terrafrom.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}