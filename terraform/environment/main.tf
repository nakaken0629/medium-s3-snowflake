provider "aws" {
  region = "ap-northeast-1"
}

provider "snowflake" {
  account  = var.account
  user     = var.user
  password = var.password
  role     = var.role
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.76"
    }
  }
}
