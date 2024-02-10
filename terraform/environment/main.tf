provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
