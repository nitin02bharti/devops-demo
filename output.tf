output "IP_address_of_VM1" {
  value = azurerm_linux_virtual_machine.vm1.*.public_ip_address
}