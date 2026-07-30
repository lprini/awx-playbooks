locals {
  vm_name =  pve-${var.vm_hostname}"
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

  dynamic "disk" {
    for_each = var.add_extra_disk == "yes" ? [1] : []
    content {
      datastore_id = var.storage_id
      interface    = "scsi2"
      size         = var.extra_disk_size_gb
      file_format  = "raw"
    }
  }

  initialization {
    datastore_id = var.storage_id
    interface    = "scsi1"

    dynamic "ip_config" {
      for_each = [1]
      content {
        ipv4 {
          address = var.ip_mode == "static" ? var.vm_ip : "dhcp"
          gateway = var.ip_mode == "static" ? var.vm_gateway : null
        }
      }
    }

    user_account {
      username = "nagix"
      keys     = [var.ssh_public_key]
      password = var.admin_password != "" ? var.admin_password : null
    }
  }

  started = true
}

resource "time_sleep" "wait_for_agent" {
  depends_on      = [proxmox_virtual_environment_vm.deploy]
  create_duration = "30s"
}

output "vm_ipv4" {
  value      = proxmox_virtual_environment_vm.deploy.ipv4_addresses
  depends_on = [time_sleep.wait_for_agent]
}

output "vm_id" {
  value = proxmox_virtual_environment_vm.deploy.vm_id
}
