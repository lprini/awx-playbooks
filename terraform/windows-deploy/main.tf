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
    hostname     = var.vm_hostname

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
