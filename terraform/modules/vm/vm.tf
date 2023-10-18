resource "azurerm_network_interface" "test" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_DS2_v2"
  admin_username      = var.admin_username
  # source_image_id     = var.packer_image
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCycItb0xqtfBKmLhNb7fFLKjirWPFELkmOt20n7RxKmCiHC4lhhe04NzZwIDQyuCbcSO6bIQqlNpnQDT90Z+n1CGZ1IGB0qzIIJiH/gKPp5E++1rwhjuRtGlc1VZJHesvZldmyxENZcRNuSmsPtEEeQm2E35imKR0bUwXHRi2UvCcA2zZqa71Mc5GmM0M/lX3tnGk1Rb8ZauVYz2U7GmkxqinH7tRGx5+7/fh1wTWYFIE35hP2K8EOwtIsmuL1GoFv2CAeYreEsWVZMmYEQldgRHvsSoALW/27wrbw0Kd5YCydhs1/gU/8u7CAqblg8msA3Em2+SQBKcXK1G87/0AnS+j8m48CWJz3rGO5LxtjoCfvx/lyTOkkv3pfMh5gFcNiUtnxJGtbCPP0ic1CsXZusFaXyHLsh6OXxHvBBgexZE7H/II85G3MzLGNgTQXzYmXv9DY+KVCxWGMDL7q4nkfC11M4aK51ab/Ha44l1jwae/KqUZs4pt5lMJqLid9OqM= luiyi_hurtado@LuiyiHurtado"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
