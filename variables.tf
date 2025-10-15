# Префикс для создаваемых объектов
variable "prefix" {
  type    = string
  default = "tg"
}

variable "vm_name" {
  type    = string
  default = "test"
}

variable "node_name" {
  type    = string
  default = "cloud"
}

variable "image_name" {
  type    = string
  default = "local:iso/focal-server-cloudimg-amd64.img"
}

# Количесвто виртуальных машин
variable "count_vm" {
  type    = number
  default = "1"
}

# Параметры виртуальной машины
variable "vm_cpu" {
  type    = number
  default = "2"
}

variable "vm_ram" {
  type    = number
  default = "2048"
}

variable "vm_root_disk_type" {
  type    = string
  default = "system"
}

variable "vm_root_disk_size" {
  type    = number
  default = 10
}

variable "vm_logs_disk_type" {
  type    = string
  default = "hdd"
}

variable "vm_logs_disk_size" {
  type    = number
  default = 10
}

variable "vm_data_disk_type" {
  type    = string
  default = "ssd"
}

variable "vm_data_disk_size" {
  type    = number
  default = 15
}

variable "vm_network_bridge" {
  type    = string
  default = "vmbr0"
}

variable "vm_network_use_dhcp" {
  type        = bool
  default     = true
}

variable "vm_network_ips" {
  type    = list
  default = ["192.168.0.220/24","192.168.0.230/24","192.168.0.240/24"]

  validation {
    condition     = var.vm_network_use_dhcp ? true : length(var.vm_network_ips) == var.count_vm
    error_message = "Количество IP-адресов должно совпадать с количеством ВМ."
  }
}

variable "vm_network_gateway" {
  type    = string
  default = "192.168.0.1"
}
