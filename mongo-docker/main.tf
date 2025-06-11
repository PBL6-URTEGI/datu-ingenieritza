// main.tf

terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

// Providers for each Proxmox VE host
provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url      = "https://${var.pm_api_host}:${var.pm_api_port}/${var.pm_api_version}/${var.pm_api_format}"
  pm_password     = var.pm_api_password
  pm_user         = var.pm_api_user
}

// ——————————————————————————————————————————————————————————
// Crear 3 contenedores LXC 
// ——————————————————————————————————————————————————————————

resource "proxmox_lxc" "singlesc" {

  count = length(var.pm_nodes)

  target_node  = var.pm_nodes[count.index]
  hostname     = "mongo-${count.index + 1}"
  ostemplate   = var.pm_ct_template
  cores        = var.pm_ct_cores
  memory       = var.pm_ct_memory_mb
  password     = var.pm_ct_password
  unprivileged = false
  start        = true

  ssh_public_keys = file("../kredentzialak/gakoa.pub")

  rootfs {
    storage = "local-lvm"
    size    = var.pm_ct_rootfs_size_gb
  }

  network {
    name   = var.pm_ct_network_name
    bridge = var.pm_ct_network_bridge
    ip     = "${cidrhost(var.pm_ct_network_subnet, count.index + 80)}/${var.pm_network_mask}"
    gw     = var.pm_network_gw
  }

  features {
    nesting = true
  }
  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=../ansible/ansible.cfg ansible-playbook -e 'ansible_ssh_private_key_file=../kredentzialak/gakoa' -i ${cidrhost(var.pm_ct_network_subnet, count.index + 80)}, ../ansible/docker-install.yaml -vvv"
  }
}
// ——————————————————————————————————————————————————————————
// Hacer APT update
// ——————————————————————————————————————————————————————————


resource "null_resource" "mongo" {
  depends_on = [
    proxmox_lxc.singlesc
  ]

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=../ansible/ansible.cfg ansible-playbook -e 'ansible_ssh_private_key_file=../kredentzialak/gakoa' -i ../ansible/mongo-inventory.yaml  ../ansible/mongo-docker.yaml -vvv"
  }
}
resource "null_resource" "security" {
  depends_on = [
    null_resource.mongo
  ]

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=../ansible/ansible.cfg ansible-playbook -e 'ansible_ssh_private_key_file=../kredentzialak/gakoa' -i ${cidrhost(var.pm_ct_network_subnet, 181)}, ../ansible/security.yaml -vvv"
  }
}
