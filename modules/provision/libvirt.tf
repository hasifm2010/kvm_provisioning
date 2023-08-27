terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

resource "libvirt_volume" "base_image_ubuntu" {
  name   = "base_image_ubuntu"
  pool = "${var.pool_name}"
  source = "${var.source_url}"
  format = "qcow2"
}

# Defining VM Volume
resource "libvirt_volume" "qcow2-disk" {
  count = length(var.vm_name)
  name = "${element(var.vm_name, count.index)}-os.qcow2"
  pool = "${var.pool_name}"
  base_volume_id = libvirt_volume.base_image_ubuntu.id
  format = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count = length(var.vm_name)
  name = "${element(var.vm_name, count.index)}-commoninit.iso"
  pool = "${var.pool_name}"
  user_data = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config[count.index].rendered
}

data "template_file" "user_data" {
  count = length(var.vm_name)
  template = file("${path.module}/cloud_init.cfg")
  vars = {
    hostname = "${element(var.vm_name, count.index)}"
    fqdn = "${element(var.vm_name, count.index)}"
  }
}

data "template_file" "network_config" {
  count = length(var.ipaddress)
  template = file("${path.module}/network_config.cfg")
  vars = {
    ipaddress = "${element(var.ipaddress, count.index)}"
    dns = "${var.dns}"
    dns_search = "${var.dns_search}"
    gateway = "${var.gateway}"
  }
}

# Define KVM domain to create
resource "libvirt_domain" "k8s-vm" {
  count = length(var.vm_name)
  name   = "${element(var.vm_name, count.index)}"
  memory = "${element(var.memory, count.index)}"
  vcpu   = "${element(var.cpu, count.index)}"
  arch   = "x86_64"
  machine = "q35"
  autostart = true
  xml {
    xslt = file("cdrom-model.xsl")
  }

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    bridge = "${var.bridge_name}"
  }

  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

  disk {
    volume_id = libvirt_volume.qcow2-disk[count.index].id
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
  }
}

# Output Server IP
#output "ip" {
#  value = "${libvirt_domain.centos7.network_interface.0.addresses.0}"
#}
