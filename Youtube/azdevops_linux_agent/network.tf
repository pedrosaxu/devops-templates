resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resourcegroupname
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = var.resourcegroupname
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.0.0/24"]
}