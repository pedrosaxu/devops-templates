locals {
  custom_data = <<CUSTOM_DATA
  #!/bin/bash
  CUSTOM_DATA
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.devops-agents-rg.name
}

resource "azurerm_network_security_rule" "allowSSH" {
  name                        = "Allow_SSH"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devops-agents-rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_public_ip" "pip" {
  count               = var.countofvms
  name                = "${var.prefix}-pip-${format("%02d", count.index)}"
  resource_group_name = azurerm_resource_group.devops-agents-rg.name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  count               = var.countofvms
  name                = "${var.prefix}-nic-${format("%02d", count.index)}"
  resource_group_name = azurerm_resource_group.devops-agents-rg.name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.pip.*.id, count.index)
  }

  tags = {
    "Level" = "rookies"
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  count                     = var.countofvms
  network_interface_id      = element(azurerm_network_interface.main.*.id, count.index)
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.countofvms
  name                            = "${var.prefix}-vm-${format("%02d", count.index)}"
  resource_group_name             = azurerm_resource_group.devops-agents-rg.name
  location                        = var.location
  size                            = "Standard_A2_v2"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
#  priority                        = "Spot"
#  eviction_policy                 = "Deallocate"
  network_interface_ids = [
    element(azurerm_network_interface.main.*.id, count.index)
  ]
#  custom_data = base64encode(local.custom_data)

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

resource "azurerm_virtual_machine_extension" "main" {
  count = var.countofvms
  name                 = "installagent"
  virtual_machine_id   = element(azurerm_linux_virtual_machine.main.*.id, count.index)
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "commandToExecute": "cd /home/trainer/ && wget https://vstsagentpackage.azureedge.net/agent/2.190.0/vsts-agent-linux-x64-2.190.0.tar.gz && mkdir myagent && cd myagent && tar zxvf /home/trainer/vsts-agent-linux-x64-2.190.0.tar.gz && chmod 777 /home/trainer/myagent"
    }
SETTINGS

}