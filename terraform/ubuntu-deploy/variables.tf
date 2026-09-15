variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "target_node" {
  type    = string
  default = "host-pve-nagixdtc02"
}

variable "template_name" {
  type    = string
  default = "ubuntu-template-build"
}

variable "vm_name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2048
}

variable "storage" {
  type    = string
  default = "local-lvm"
}
