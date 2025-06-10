// ────────────────────────────────────────────────────────────────────────────
// terraform.tfvars
// Valores concretos para las variables
// ────────────────────────────────────────────────────────────────────────────

############
# Provider #
############
pm_api_host                     = "10.0.2.20"
pm_api_port                     = "8006"
pm_api_version                  = "api2"
pm_api_format                   = "json"
pm_api_user                     = "root@pam"
pm_api_password                 = "popbl6kafka1"

########
# Node #
########
pm_node                          = "proxmox1"
pm_nodes    = ["kafka1","kafka2","kafka3"]
//pm_nodes    = ["kafka1"]
###########
# Network #
###########
pm_network_gw                   = "10.0.2.2"
pm_network_mask                 = "24"
pm_ct_network_subnet = "10.0.2.0/24"
######
# VM #
######
pm_ct_template                  = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
pm_ct_password                  = "root1"
pm_ct_cores                     = "2"
pm_ct_memory_mb                 = "2048"
pm_ct_rootfs_size_gb            = "20G"
pm_ct_network_name              = "eth0"
pm_ct_network_bridge            = "vmbr0"
