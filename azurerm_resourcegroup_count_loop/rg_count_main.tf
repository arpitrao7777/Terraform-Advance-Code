resource "azurerm_resource_group" "rg-1" {
  count    = 2
  name     = "rg-${count.index+1}"
  location = var.location
}

variable "location" {}

resource "azurerm_resource_group" "rg-2" {
  count    = var.rg ? 3 : 0
  name     = "rgs-${count.index + 1}"
  location = var.location
}
variable "rg" {
  type = bool
}