resource "azurerm_resource_group" "rg-1" {
  name     = "rg-1"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg-1.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_storage_account" "stg" {
  name                     = "stg8307532971"
  resource_group_name      = azurerm_resource_group.rg-1.name
  location                 = azurerm_resource_group.rg-1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action = "Deny"
    ip_rules       = ["157.49.150.195"] # if you want to remove access to this public ip address then remove this line
    # ip rules always take only public ip addresses
    # virtual_network_subnet_ids = [azurerm_subnet.subnet.id] #to access the storage account only from this vnet and above defined subnet then uncomment his line
  }
}
