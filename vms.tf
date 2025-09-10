resource "azurerm_linux_virtual_machine" "vm1" {
  count                           = length(var.subnetname)
  name                            = "trainer-vm1-${count.index}"
  location                        = azurerm_resource_group.rg1.location
  resource_group_name             = azurerm_resource_group.rg1.name
  size                            = "Standard_B1s"
  admin_username                  = "docker"
  admin_password                  = "Docker@12345"
  disable_password_authentication = false
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    sku       = "22_04-lts"
    offer     = "0001-com-ubuntu-server-jammy"
    # sku     = "24_04-lts-gen2"
    # offer   = "0001-com-ubuntu-server-jammy"
    version = "latest"
  }
  custom_data = count.index == 0 ? base64encode(<<-EOF
        #!/bin/bash
        sudo apt-get update
        sudo apt-get install -y software-properties-common
        sudo add-apt-repository --yes --update ppa:ansible/ansible
        sudo apt-get install -y ansible
        EOF
  ) : null
  network_interface_ids = [azurerm_network_interface.nic1[count.index].id]
}
