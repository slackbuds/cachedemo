provider "aws" {
  region = var.region
  default_tags {
    tags = {
      env = "cache-demo"
    }
  }
}
