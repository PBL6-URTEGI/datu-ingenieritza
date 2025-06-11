// ────────────────────────────────────────────────────────────────────────────
// variables.tf
// Declaración de todas las variables usadas
// ────────────────────────────────────────────────────────────────────────────

############
# Provider #
############
variable "pm_ct_network_subnet" {
  description = "Network subnet for the containers (CIDR format)"
  type        = string
}
variable "pm_api_hosttail_proba" {
  description = "Proxmox API host"
  type        = string
}

variable "pm_api_porttail_proba" {
  description = "Proxmox API port"
  type        = string
}

variable "pm_api_versiontail_proba" {
  description = "Proxmox API version"
  type        = string
}

variable "pm_api_formattail_proba" {
  description = "Proxmox API format"
  type        = string
}

variable "pm_api_usertail_proba" {
  description = "Proxmox login username"
  type        = string
}

variable "pm_api_passwordtail_proba" {
  description = "Proxmox login password"
  type        = string
}

########
# Node #
########
variable "pm_nodetail_proba" {
  description = "Proxmox node to create the resource"
  type        = string
}

###########
# Network #
###########
variable "pm_networktail_proba" {
  description = "LXC network address"
  type        = string
}

variable "pm_network_gwtail_proba" {
  description = "LXC gateway IP address"
  type        = string
}

variable "pm_network_masktail_proba" {
  description = "LXC IP address mask"
  type        = string
}

######
# VM #
######
variable "pm_ct_templatetail_proba" {
  description = "Operating system template for LXC"
  type        = string
}

variable "pm_ct_passwordtail_proba" {
  description = "LXC password for root user"
  type        = string
}

variable "pm_ct_vmidtail_proba" {
  description = "VM ID"
  type        = string
}

variable "pm_ct_corestail_proba" {
  description = "Number of CPU cores"
  type        = string
}

variable "pm_ct_memory_mbtail_proba" {
  description = "RAM memory in MB"
  type        = string
}

variable "pm_ct_rootfs_size_gbtail_proba" {
  description = "LXC HDD size"
  type        = string
}

variable "pm_ct_network_nametail_proba" {
  description = "LXC network interface name"
  type        = string
}

variable "pm_ct_network_bridgetail_proba" {
  description = "Proxmox bridge name"
  type        = string
}

variable "pm_ct_hostnametail_proba" {
  description = "Proxmox node to create the resource"
  type        = string
}

variable "pm_ct_iptail_proba" {
  description = "LXC IP address"
  type        = string
}

