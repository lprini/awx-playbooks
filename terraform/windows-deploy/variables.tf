variable "pve_endpoint" {
  type = string
}

variable "pve_api_token" {
  type      = string
  sensitive = true
}

variable "vm_hostname" {
  type        = string
  description = "Hostname segment for the new Windows VM"
}

variable "ip_mode" {
  type        = string
  description = "dhcp or static"
  default     = "dhcp"
}

variable "vm_ip" {
  type        = string
  description = "Static IP in CIDR format, e.g. 10.21.40.210/24"
  default     = ""
}

variable "vm_gateway" {
  type    = string
  default = ""
}

variable "template_vm_id" {
  type    = number
  default = 131
}

variable "node_name" {
  type    = string
  default = "host-pve-nagixdtc02"
}

variable "storage_id" {
  type    = string
  default = "local-lvm"
}

variable "cpu_cores" {
  type    = number
  default = 4
}

variable "memory_mb" {
  type    = number
  default = 4096
}

variable "disk_size_gb" {
  type    = number
  default = 60
}

variable "admin_password" {
  type      = string
  sensitive = true
}
