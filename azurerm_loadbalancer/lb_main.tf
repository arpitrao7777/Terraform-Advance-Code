resource "azurerm_public_ip" "pip" {
  name                = "pip-1"
  location            = "centralindia"
  resource_group_name = "rg-001"
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = "TestLoadBalancer"
  location            = "centralindia"
  resource_group_name = "rg-001"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

data "azurerm_network_interface" "nic" {
  name                = "acctest-nic"
  resource_group_name = "rg-001"
}

resource "azurerm_lb_backend_address_pool" "netflixpool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "nics" {
  network_interface_id    = data.azurerm_network_interface.nic.id
  ip_configuration_name   = "config"
  backend_address_pool_id = azurerm_lb_backend_address_pool.netflixpool.id
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "ssh-running-probe"
  port            = 80
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.netflixpool.id]
}
