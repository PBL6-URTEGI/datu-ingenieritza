// ────────────────────────────────────────────────────────────────────────────
// terraform.tfvars
// Valores concretos para las variables
// ────────────────────────────────────────────────────────────────────────────

############
# Provider #
############
pm_api_hosttail_proba                     = "10.0.2.10"
pm_api_porttail_proba                     = "8006"
pm_api_versiontail_proba                  = "api2"
pm_api_formattail_proba                   = "json"
pm_api_usertail_proba                     = "root@pam"
pm_api_passwordtail_proba                 = "popbl6zone1"

########
# Node #
########
pm_nodetail_proba                          = "proxvider"

###########
# Network #
###########
pm_networktail_proba                      = "10.0.2.0"
pm_network_gwtail_proba                   = "10.0.2.2"
pm_network_masktail_proba                 = "24"
pm_ct_network_subnet = "10.0.2.0/24"
######
# VM #
######
pm_ct_templatetail_proba                  = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
pm_ct_passwordtail_proba                  = "tailscaleroot"
pm_ct_vmidtail_proba                      = "103"
pm_ct_corestail_proba                     = "1"
pm_ct_memory_mbtail_proba                 = "1024"
pm_ct_rootfs_size_gbtail_proba            = "20G"
pm_ct_network_nametail_proba              = "eth0"
pm_ct_network_bridgetail_proba            = "vmbr0"
pm_ct_hostnametail_proba                  = "tailscale"
pm_ct_iptail_proba                        = "10.0.2.40"
