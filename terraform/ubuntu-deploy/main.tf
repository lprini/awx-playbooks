resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = var.vm_hostname
  target_node = var.node_name
  clone       = "ubuntu-template-build"
  full_clone  = true

  cores   = var.cpu_cores
  sockets = 1
  memory  = var.memory_mb
  agent   = 1

  disks {
    scsi {
      scsi0 {
        disk {
          size    = "${var.disk_size_gb}G"
          storage = var.storage_id
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
