provider "aws" {
  region = "ap-northeast-1"
}

provider "snowflake" {
  account  = var.account
  user     = var.user
  password = var.password
  role     = "ACCOUNTADMIN"
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
