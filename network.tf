resource "azurerm_virtual_network" "vnet1" {
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  name                = var.vnetname
  address_space       = [var.vnetaddr[0]]
}
resource "azurerm_subnet" "s1" {
  count                = length(var.subnetname)
  name                 = var.subnetname[count.index]
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnetaddr[count.index]]
}

resource "azurerm_network_interface" "nic1" {
  count               = length(var.subnetname)
  name                = "${var.nicname}-${count.index}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  ip_configuration {
    name                          = "ip11-${var.nicname}-${count.index}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.s1[count.index].id
    public_ip_address_id          = azurerm_public_ip.pip1[count.index].id
  }
}

resource "azurerm_public_ip" "pip1" {
  count               = length(var.subnetname)
  name                = "trainer1-${count.index}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"

}


