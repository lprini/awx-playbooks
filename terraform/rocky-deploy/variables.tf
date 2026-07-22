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
  type        = string
  default     = ""
}

variable "template_vm_id" {
  type    = number
  default = 109
}

variable "node_name" {
  type    = string
  default = "pve-nagixdtc"
}
