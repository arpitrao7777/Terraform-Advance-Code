resource "azurerm_resource_group" "main" {
  name     = "rg-0001"
  location = "westus"

lifecycle {
    prevent_destroy = true
    ignore_changes = [tags]
  } 
}

resource "azurerm_storage_account" "stg" {
  depends_on               = [azurerm_resource_group.main]
  name                     = "arpit2548"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

lifecycle {
    prevent_destroy = true
    ignore_changes = [tags]
  }

}

# terraform taint azurerm_resource_group.main
# command is used for taint