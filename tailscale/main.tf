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
  alias = "tail1"
  pm_tls_insecure = true
  pm_api_url      = "https://${var.pm_api_hosttail_proba}:${var.pm_api_porttail_proba}/${var.pm_api_versiontail_proba}/${var.pm_api_formattail_proba}"
  pm_password     = var.pm_api_passwordtail_proba
  pm_user         = var.pm_api_usertail_proba
}

// ——————————————————————————————————————————————————————————
// Crear 3 contenedores LXC 
// ——————————————————————————————————————————————————————————

resource "proxmox_lxc" "singlesctail_proba" {

  provider = proxmox.tail1

  target_node  = var.pm_nodetail_proba
  ostemplate   = var.pm_ct_templatetail_proba
  cores        = var.pm_ct_corestail_proba
  memory       = var.pm_ct_memory_mbtail_proba
  hostname     = var.pm_ct_hostnametail_proba
  password     = var.pm_ct_passwordtail_proba
  unprivileged = false
  start        = true

  ssh_public_keys = file("../kredentzialak/gakoa.pub")

  rootfs {
    storage = "local-lvm"
    size    = var.pm_ct_rootfs_size_gbtail_proba
  }

  network {
    name   = var.pm_ct_network_nametail_proba
    bridge = var.pm_ct_network_bridgetail_proba
    ip = "${var.pm_ct_iptail_proba}/${var.pm_network_masktail_proba}"
    gw     = var.pm_network_gwtail_proba
  }

  features {
    nesting = true
  }
  
  provisioner "local-exec" {
    command = <<EOT
      echo "🔧 Esperando a que el contenedor arranque..."
      sleep 20

      echo "🧹 Limpiando entrada antigua de known_hosts..."
      ssh-keygen -f "/root/.ssh/known_hosts" -R "${var.pm_ct_iptail_proba}" || true

      echo "🔐 Habilitando acceso SSH root..."
      ssh -o StrictHostKeyChecking=no -i ../kredentzialak/gakoa root@${var.pm_ct_iptail_proba} "sed -i 's/^#\\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && systemctl reload sshd"

      sleep 10

      echo "🔧 Apagando contenedor para modificar configuración..."
      pct stop ${var.pm_ct_iptail_proba}

      echo "🔧 Añadiendo configuración para privilegios y tun..."
      echo "lxc.cgroup2.devices.allow = c 10:200 rwm" >> /etc/pve/lxc/${var.pm_ct_iptail_proba}.conf
      echo "lxc.mount.entry = /dev/net/tun dev/net/tun none bind,create=file" >> /etc/pve/lxc/${var.pm_ct_iptail_proba}.conf
      echo "features: nesting=1,fuse=1" >> /etc/pve/lxc/${var.pm_ct_iptail_proba}.conf
      echo "unprivileged: 0" >> /etc/pve/lxc/${var.pm_ct_iptail_proba}.conf

      echo "🔧 Reiniciando contenedor..."
      pct start ${var.pm_ct_iptail_proba}
      
      echo "🚀 Ejecutando Ansible Playbook..."
      ANSIBLE_CONFIG=../ansible/ansible.cfg ansible-playbook -e "ansible_ssh_private_key_file=../kredentzialak/gakoa" -i "${var.pm_ct_iptail_proba}," ${path.module}/../ansible/install-tailscale.yaml
    EOT
  }
}
