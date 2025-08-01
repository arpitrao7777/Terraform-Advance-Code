resource "azurerm_resource_group" "rg-1" {
  name     = "rg-01"
  location = "eastus"
}

output "azurerm_resource_group_rg-1_id" {
  value = azurerm_resource_group.rg-1.id
}