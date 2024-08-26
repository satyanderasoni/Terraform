vm = {
  resource_group_name = "rg_example12"
  location            = "westus2"
  vnet_name           = "vnet4"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  subnet_name         = "subnet3"
  address_prefixes    = ["10.0.1.0/24"]
  nic_name            = "nic2"
  vm_name             = "example_vm1"
  storage_os_disk     = "example_vm1disk1"
}
