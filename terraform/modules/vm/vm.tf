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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpvdWNI8sC2SesjJOBiIyqcARjGOgYE7W50gkUIvfEiDKzg8TQOeOhtOTfJbGUGha7fcV2M2F5LhuBGxWPkblhQxl9Tg505pazcPomrx6/K65O++0jozFHEL0ZdRUXR+6b8v+rm1KSpFtu+viY78YRy/eEipl3k+h/o+3lJU1gkQ6YJwES0DqaWSMu3VuNmSFVzRGzRSs3UbOvobILysSFiKEEl2j6TgokP01pLIuVEnwrcr5niiIlHrGlJyC43FeYso31ggBjqI4KXp5r7vy1Y+y3aO/cQT//lHYYWHgGjPhMEf7QDIlmDU0ugW/yEtOkTNgjUdg72t3Q75NHMrWVZfNgy6HojP5RfoHMooZJVi3CZ4C7G65FzTnexNzZCpmWz0VPnss9IzAMLx7H5tyMdelO3e9bXi79DFl7T9SHADoqtR+4hp5rypbojnxdp1VVGfGHrS1FSr60Rj0qf5/+72nsLhh3Y1ezZDVlHuiyUsWN4cUtsTgXGfwhcP8cerE= luiyi@Luiyi_HB"
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
