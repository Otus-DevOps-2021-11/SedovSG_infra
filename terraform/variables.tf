variable cloud_id {
  description = "Cloud id"
}

variable folder_id {
  description = "Folder id"
}

variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}

variable public_key_path {
  description = "Public ssh key"
}

variable private_key_path {
  description = "Private ssh key"
  default     = "~/.ssh/id_rsa.yc"
}

variable image_id {
  description = "image id"
}

variable subnet_id {
  description = "Subnet id"
}

variable service_account_key_file {
  description = "Service Account key file"
}

variable instance_count {
  description = "Number of instances to create"
  default     = 1
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "fd8ldt9kbu2vlisc75dk"
}

variable db_disk_image {
  description = "Disk image for reddit mongodb"
  default     = "fd8vuf16rslseou1e3tu"
}
