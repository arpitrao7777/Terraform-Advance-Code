variable "storage_account_details" {
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_replication_type = optional(string, "GRS")
  }))
}

resource "azurerm_resource_group" "rg-1" {
  name     = "rg-1"
  location = "West Europe"
}

resource "azurerm_storage_account" "stg" {
  depends_on               = [azurerm_resource_group.rg-1]
  for_each                 = var.storage_account_details
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = each.value.account_replication_type

  network_rules {
    default_action = "Deny"
    ip_rules       = ["100.0.0.1"]
  }
}
