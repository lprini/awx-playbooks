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
    timeout = "5m"
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
      keys = [var.ssh_public_key]
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
