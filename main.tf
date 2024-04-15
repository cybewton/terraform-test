resource "azurerm_resource_group" "example" {
  name     = "terraform-controller-rg"
  location = "canadacentral"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "terraform-controller-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  count                = 3
  name                 = "terraform-controller-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.${count.index + 1}.0/24"]
}
