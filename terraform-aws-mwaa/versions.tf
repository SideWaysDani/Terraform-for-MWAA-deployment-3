terraform {
  required_version = "3.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.63.0"
    }
  }
}
