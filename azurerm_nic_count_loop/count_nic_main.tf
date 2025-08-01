variable "rg_name" {}
variable "location" {}
variable "enable_pip" {}

resource "azurerm_resource_group" "rg-1" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.rg_name}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "sb-${var.rg_name}"
  resource_group_name  = azurerm_resource_group.rg-1.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pip" {
  count               = var.enable_pip ? 1 : 0
  name                = "pip-${var.rg_name}"
  resource_group_name = azurerm_resource_group.rg-1.name
  location            = azurerm_resource_group.rg-1.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "example" {
  name                = "nic-${var.rg_name}"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_pip ? azurerm_public_ip[0].id : null
  }
}
