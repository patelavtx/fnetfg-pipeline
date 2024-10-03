
provider "aviatrix" {
  controller_ip           = var.controller_ip
  username                = var.username
  password                = var.password
  skip_version_validation = false
}


/*
provider "aviatrix" {
  controller_ip           = var.avtx_controller_ip
  username                = var.avtx_admin_user
  password                = var.avtx_admin_password
  skip_version_validation = false
}
*/