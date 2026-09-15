resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = var.vm_name
  vmid        = var.vm_id
  target_node = var.target_node
  clone       = var.template_name
  full_clone  = true

  cores   = var.cores
  sockets = 1
  memory  = var.memory
  agent   = 1

  disks {
    scsi {
      scsi0 {
        disk {
          size    = "20G"
          storage = var.storage
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
