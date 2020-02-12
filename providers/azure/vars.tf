# required variables
variable "hostname" {
  description = "name of the machine to create"
  default = "azurevm"
}

variable "name_prefix" {
  description = "unique part of the name to give to resources"
  default = "vs"
}

variable "ssh_public_key" {
  description = "public key for ssh access"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFvlOxIbuG7Rzkb6XrbKQ1lsAQ6gQ7lIKgfIA6zkZTYlCyngKnqP4BTDDCC4MXwNq7AKrAEn8SyfgSVvPM9MsURrkYINboHTL1xWscz+qKSxDA2xqeVUxfSZ/Hfbj+eJqGt/ncV9gYfn4zoDcvVfiB2nBDYy90sCjI1diq+n+JIdW8I+zbMplBA+K3eFlVoK69g16stcjVSaiM71qVa6wPw00cQcZpjVGwl77MQaxNLmzkfJxGa0WtocZb8Lw3753mq4MFxVy+M38m/CcKYp2CwRiXZGu3WiO/G4OoyU5MkmfOy0JLPjsiERyLP8xA5x50fcpHW2Q20aB+BQ70Ycxl slavko@ROCINANTE"
}

# optional variables
variable "location" {
  description = "region where the resources should exist"
  default     = "South Central US"
}

variable "vnet_address_space" {
  description = "full address space allowed to the virtual network"
  default     = "10.0.0.0/16"
}

variable "subnet_address_space" {
  description = "the subset of the virtual network for this subnet"
  default     = "10.0.10.0/24"
}

variable "storage_account_tier" {
  description = "type of storage account"
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "type of storage account"
  default     = "LRS"
}

#https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/

# The sizes available in the current region could be: Standard_A0,Standard_A1,Standard_A2,Standard_A3,Standard_A5,
# Standard_A4,Standard_A6,Standard_A7,Basic_A0,Basic_A1,Basic_A2,Basic_A3,Basic_A4,Standard_D1_v2,Standard_D2_v2,
# ....
#  Get-AzComputeResourceSku | where {$_.Locations -icontains "southcentralus"}

# Find out more on the available VM sizes in each region at https://aka.ms/azure-regions."

variable "vm_size" {
  description = "size of the vm to create"
  default     = "Standard_F1"
}

variable "image_publisher" {
  description = "name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "the name of the offer (az vm image list)"
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "image sku to apply (az vm image list)"
  default     = "16.04-LTS"
}

variable "image_version" {
  description = "version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "administrator user name"
  default     = "ubuntu"
}

variable "admin_password" {
  description = "administrator password (recommended to disable password auth)"
  default     = "SecureIsToDosablePasswordAuthentication!"
}

variable "disable_password_authentication" {
  description = "toggle for password auth (recommended to keep disabled)"
  default     = true
}
