locals {
  custom_tags = {
    app_code    = var.app_code
    environment = var.environment
  }
  stg_tags = {
    app_id = var.app_id
  }
  vnet_tags = {
    cost_center = var.cost_center
  }
}
