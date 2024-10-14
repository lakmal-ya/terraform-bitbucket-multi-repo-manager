terraform {
  required_providers {
    bitbucket = {
      source  = "DrFaust92/bitbucket"
      version = "2.32.0"
    }
  }
}

provider "bitbucket" {
  username = var.provider_username
  password = var.provider_app_key
}