terraform {
  required_version = "=1.6.4"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
    google = {
      source = "hashicorp/google"
      version = "5.11.0"
    }
    http = {
      source = "hashicorp/http"
      version = "3.4.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.4.1"
    }
    tls = {
      source = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}