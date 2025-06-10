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
variable "pm_api_host" {
  description = "Proxmox API host"
  type        = string
}

variable "pm_api_port" {
  description = "Proxmox API port"
  type        = string
}

variable "pm_api_version" {
  description = "Proxmox API version"
  type        = string
}

variable "pm_api_format" {
  description = "Proxmox API format"
  type        = string
}

variable "pm_api_user" {
  description = "Proxmox login username"
  type        = string
}

variable "pm_api_password" {
  description = "Proxmox login password"
  type        = string
}

########
# Node #
########
variable "pm_node" {
  description = "Proxmox node to create the resource"
  type        = string
}

###########
# Network #
###########
variable "pm_network" {
  description = "LXC network address"
  type        = string
}

variable "pm_network_gw" {
  description = "LXC gateway IP address"
  type        = string
}

variable "pm_network_mask" {
  description = "LXC IP address mask"
  type        = string
}

######
# VM #
######
variable "pm_ct_template" {
  description = "Operating system template for LXC"
  type        = string
}

variable "pm_ct_password" {
  description = "LXC password for root user"
  type        = string
}

variable "pm_ct_vmid" {
  description = "VM ID"
  type        = string
}

variable "pm_ct_cores" {
  description = "Number of CPU cores"
  type        = string
}

variable "pm_ct_memory_mb" {
  description = "RAM memory in MB"
  type        = string
}

variable "pm_ct_rootfs_size_gb" {
  description = "LXC HDD size"
  type        = string
}

variable "pm_ct_network_name" {
  description = "LXC network interface name"
  type        = string
}

variable "pm_ct_network_bridge" {
  description = "Proxmox bridge name"
  type        = string
}

variable "pm_ct_hostname" {
  description = "Proxmox node to create the resource"
  type        = string
}

variable "pm_ct_ip" {
  description = "LXC IP address"
  type        = string
}

