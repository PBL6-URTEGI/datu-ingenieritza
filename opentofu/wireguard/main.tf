terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://10.0.2.10:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "root1"
  pm_tls_insecure = true
}
resource "proxmox_lxc" "wireguard" {
    target_node  = "server"
    hostname     = "wireguard"
    ostemplate   = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
    password     = "root1"
    unprivileged = true
    start        = true
    vmid         = 140
}
rootfs {
    storage = "local-lvm"
    size    = "15G"
  }
  provisioner "local-exec" {
  command = <<EOT
    echo "Esperando a que el contenedor arranque..."
    sleep 20

    echo "Habilitando SSH en el contenedor..."
    ssh root@10.0.2.10 "pct exec 140 -- /bin/bash -c 'sed -i \"s/^#\\?PermitRootLogin.*/PermitRootLogin yes/\" /etc/ssh/sshd_config && service ssh restart'"

    sleep 10

    ssh-copy-id root@10.0.2.11

    echo "Ejecutando playbook de Ansible para instalar Hadoop..."
    ansible-playbook -i ansible/inventory.ini ansible/playbook.yml

  EOT
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.2.11/24"
    gw     = "10.0.2.2"
  }
  ssh_public_keys = file("~/.ssh/id_rsa.pub")
  features {
    nesting = true
  }
}
