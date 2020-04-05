locals {
  default_tags = {
    managed_by  = "terraform"
    project     = var.customer
    environment = var.environment
  }
}
