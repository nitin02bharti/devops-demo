resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsgname
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  dynamic "security_rule" {
    for_each = var.nsgrules1
    content {
      name                       = security_rule.value.rulename
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = security_rule.value.protocol
      source_port_range          = "*"
      destination_port_range     = security_rule.value.dport
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "s1nsgassoc" {
  count                     = length(var.subnetname)
  subnet_id                 = azurerm_subnet.s1[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}