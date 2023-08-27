terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

module "provision" {
  source = "../../modules/provision"
  providers = {
    libvirt = libvirt
  }
  vm_name         = var.vm_name
  pool_name       = var.pool_name
  source_url      = var.source_url
  memory          = var.memory
  cpu             = var.cpu
  bridge_name     = var.bridge_name
  ipaddress       = var.ipaddress
  dns             = var.dns
  dns_search      = var.dns_search
  gateway         = var.gateway
  domain          = var.domain
}