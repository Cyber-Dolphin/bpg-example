resource "proxmox_virtual_environment_file" "meta_data_cloud_config" {
  count     = "${var.count_vm}"

  content_type = "snippets"
  datastore_id = "snippets"
  node_name = "${var.node_name}"

  source_raw {
    data = <<EOF
local-hostname: "${var.prefix}-${var.vm_name}-${count.index}"
    EOF

    file_name = "meta-data-cloud-config-${var.prefix}-${var.vm_name}-${count.index}.yaml"
  }
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name = "${var.node_name}"

  source_raw {
    data      = file("config.cfg")
    file_name = "user-data-cloud-config-${var.prefix}-${var.vm_name}.yaml"
  }
}