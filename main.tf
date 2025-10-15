resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count     = "${var.count_vm}"
  name      = "${var.prefix}-${var.vm_name}-${count.index}"
  node_name = "${var.node_name}"

  agent {
    enabled = true
  }
  
  stop_on_destroy = true

  cpu {
    cores = "${var.vm_cpu}"
  }

  memory {
    dedicated = "${var.vm_ram}"
  }

  disk {
    datastore_id = "${var.vm_root_disk_type}"
    file_id      = "${var.image_name}"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = "${var.vm_root_disk_size}"
  }

  disk {
    datastore_id = "${var.vm_logs_disk_type}"
    file_format  = "raw"
    interface    = "virtio1"
    size         = "${var.vm_logs_disk_size}"
  }

  disk {
    datastore_id = "${var.vm_data_disk_type}"
    file_format  = "raw"
    interface    = "virtio2"
    size         = "${var.vm_data_disk_size}"
  }

  initialization {

    datastore_id = "${var.vm_root_disk_type}"
    
    dynamic "ip_config" {
      for_each = var.vm_network_use_dhcp ? [1] : []
      content {
        ipv4 {
          address = "dhcp"
        }
      }
    }

    dynamic "ip_config" {
      for_each = var.vm_network_use_dhcp ? [] : [1]
      content {
        ipv4 {
          address = var.vm_network_ips[count.index]
          gateway = var.vm_network_gateway
        }
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
    
    meta_data_file_id = proxmox_virtual_environment_file.meta_data_cloud_config[count.index].id
    
  }

  network_device {
    bridge = "${var.vm_network_bridge}"
  }

}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.ubuntu_vm[*].ipv4_addresses[1][0]
}