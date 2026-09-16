variable "pve_endpoint" { type = string }
variable "pve_api_token" { type = string; sensitive = true }
variable "vm_hostname" { type = string }
variable "ip_mode" { type = string; default = "dhcp" }
variable "vm_ip" { type = string; default = "" }
variable "vm_gateway" { type = string; default = "" }
variable "template_vm_id" { type = number; default = 128 }
variable "node_name" { type = string; default = "host-pve-nagixdtc02" }
variable "storage_id" { type = string; default = "local-lvm" }
variable "cpu_cores" { type = number; default = 4 }
variable "memory_mb" { type = number; default = 4096 }
variable "disk_size_gb" { type = number; default = 60 }
variable "admin_password" { type = string; sensitive = true }

locals {
  vm_name = "pve-${var.vm_hostname}"
}

resource "proxmox_virtual_environment_vm" "deploy" {
  name      = local.vm_name
  node_name = var.node_name
  pool_id   = "terraform-managed"

  clone {
    vm_id        = var.template_vm_id
    full         = true
    datastore_id = var.storage_id
  }

  agent {
    enabled = true
    timeout = "5m"
  }

  cpu {
    cores = var.cpu_cores
    type  = "host"
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = var.storage_id
    interface    = "scsi0"
    size         = var.disk_size_gb
    file_format  = "raw"
  }

  initialization {
    datastore_id = var.storage_id
    interface    = "scsi1"

    ip_config {
      ipv4 {
        address = lower(var.ip_mode) == "static" ? var.vm_ip : "dhcp"
        gateway = lower(var.ip_mode) == "static" ? var.vm_gateway : null
      }
    }

    user_account {
      username = "Administrator"
      password = var.admin_password
    }
  }

  started = true
}

output "vm_id" {
  value = proxmox_virtual_environment_vm.deploy.vm_id
}
