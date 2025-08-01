resource "azurerm_resource_group" "rg-1" {
  name     = var.rg_name
  location = var.location
  tags     = local.custom_tags
}

resource "azurerm_storage_account" "stg" {
  depends_on               = [azurerm_resource_group.rg-1]
  name                     = "stg83075-${var.rg_name}"
  location                 = azurerm_resource_group.rg-1.location
  resource_group_name      = azurerm_resource_group.rg-1.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = merge(local.custom_tags, local.stg_tags)
}

resource "azurerm_virtual_network" "vnet" {
  depends_on          = [azurerm_resource_group.rg-1]
  name                = "vnet1-${var.rg_name}"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name
  address_space       = ["10.0.0.0/16"]
  tags                = merge(local.custom_tags, local.vnet_tags)
}
