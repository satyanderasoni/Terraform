rg = {
  name     = "rg_example9"
  location = "westus2"
}

vnet = {
  name          = "vnet2"
  address_space = ["10.0.0.0/16"]
  dns_servers   = ["10.0.0.4", "10.0.0.5"]
}


subnet = {
  name             = "subnet1"
  address_prefixes = ["10.0.1.0/24"]
}
