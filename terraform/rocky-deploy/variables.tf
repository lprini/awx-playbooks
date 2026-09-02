variable "pve_endpoint" {
  type = string
}

variable "pve_api_token" {
  type      = string
  sensitive = true
}

variable "vm_hostname" {
  type        = string
  description = "Hostname segment for the new VM"
}

variable "ip_mode" {
  type        = string
  description = "dhcp or static"
  default     = "dhcp"
}

variable "vm_ip" {
  type        = string
  description = "Static IP in CIDR format, e.g. 10.21.40.60/24 (ignored if ip_mode = dhcp)"
  default     = ""
}

variable "vm_gateway" {
  type    = string
  default = ""
}

variable "template_vm_id" {
  type    = number
  default = 109
}

variable "node_name" {
  type        = string
  description = "Target Proxmox node where the VM will be created"
  default     = "host-pve-nagixdtc02"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key to inject into the new VM"
}

variable "cpu_cores" {
  type    = number
  default = 2
}

variable "memory_mb" {
  type    = number
  default = 2048
}

variable "disk_size_gb" {
  type        = number
  default     = 40
  description = "Main disk size in GB. Proxmox can only grow disks, never shrink."
}

variable "add_extra_disk" {
  type    = string
  default = "no"
}

variable "extra_disk_size_gb" {
  type    = number
  default = 20
}

variable "admin_password" {
  type      = string
  sensitive = true
  default   = ""
}

variable "storage_id" {
  type        = string
  description = "Target storage pool for VM disks and cloud-init"
  default     = "local-lvm"
}
