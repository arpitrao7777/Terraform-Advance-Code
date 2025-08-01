variable "ips_allowed" {}

resource "azurerm_resource_group" "rg-1" {
  name     = "rg-1"
  location = "West Europe"
}

resource "azurerm_storage_account" "stg" {
  name                     = "stg8307532971"
  resource_group_name      = azurerm_resource_group.rg-1.name
  location                 = azurerm_resource_group.rg-1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  dynamic "network_rules" {
    for_each = var.ips_allowed == null ? [] : [1] # using set creating ip rules
    # for_each = var.ips_allowed == null ? {} : {key = "1"} # using map creating ip rules
    # no. of ip rules are not based on these numbers as [1] but depends on how many values passed in terraform.tfvars
    content {
      default_action = "Deny"
      ip_rules       = var.ips_allowed
    }
  }
}