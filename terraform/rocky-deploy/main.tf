locals {
  vm_name = "srv-${var.vm_hostname}"
}

resource "proxmox_virtual_environment_vm" "deploy" {
  name      = local.vm_name
  node_name = var.node_name
  pool_id   = "terraform-managed"

  clone {
    vm_id = var.template_vm_id
    full  = false
  }

  agent {
    enabled = true
  }

  initialization {
    datastore_id = "local-lvm"

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
      keys = [file("~/.ssh/id_ed25519.pub")]
    }
  }

  started = true
}

output "vm_ipv4" {
  value = proxmox_virtual_environment_vm.deploy.ipv4_addresses
}
