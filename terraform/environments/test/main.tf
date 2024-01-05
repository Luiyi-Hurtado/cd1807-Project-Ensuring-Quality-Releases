provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate2621320790"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
    access_key           = "q0bB6h3eYs/HiVsaaVTi0Doxt95F/mh59WswvsMMy7VxWSlsTil9Wk4KonXWXj47GVp61FkodKS8+ASt916sXw==s"
  }
}
module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
resource "azurerm_resource_group" "Azuredevops" {
  name     = "Azuredevops"
  location = "${var.location}"
}
module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group       = "${module.resource_group.resource_group_name}"
  address_prefix_test  = "${var.address_prefix_test}"
}
module "nsg-test" {
  source           = "../../modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group   = "${module.resource_group.resource_group_name}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group   = "${module.resource_group.resource_group_name}"
}
# module "vm" {
#   source               = "../../modules/vm"
#   location             = "${var.location}"
#   resource_group       = "${module.resource_group.resource_group_name}"
#   application_type     = "${var.application_type}"
#   subnet_id            = "${module.network.subnet_id_test}"
#   vm_admin_username    = "adminuser"
#   public_ip_address_id = "${module.publicip.public_ip_address_id}"
#   packer_image         = "/subscriptions/a4b11da3-2642-4ae2-b8e0-ba40545a13d6/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/myPackerImage"
#   vm_size              =  "Standard_B1s"
#   resource_type        =  "webapp"
# }
