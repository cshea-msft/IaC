// Create a Resource Group



// Create a Disk Encryption Set
resource "azurerm_disk_encryption_set" "dse" {
  name = "dse-${var.environment}"
  resource_group_name = azure
}

// Create a Windows VM

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "vm-${var.location}-${var.environment}"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]
  encryption_at_host_enabled = true
  tags                  = var.tags
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_encryption_set_id = var.disk_encryption_set_id
  }
}