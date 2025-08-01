resource "azurerm_resource_group" "rgs" {
  name     = "rg1"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  location            = azurerm_resource_group.rgs.location
  resource_group_name = azurerm_resource_group.rgs.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
  }
}

output "azurerm_vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "azurerm_subnet1_id" {
  value = element(tolist(azurerm_virtual_network.vnet.subnet), 0).id
}

output "azurerm_subnet2_id" {
  value = element(tolist(azurerm_virtual_network.vnet.subnet), 1).id
}