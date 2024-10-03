
variable "controller_ip" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

/*
# test alternate provider vars
variable "avtx_controller_ip" {
  type = string
}

variable "avtx_admin_user" {
  type = string
}

variable "avtx_admin_password" {
  type = string
}
*/

#==============
variable "azure_account" {
  type = string
}

variable "azure_region" {
  type    = string
  default = "UK South"
}

variable "ha_gw" {
  type    = string
  default = "true"
}


variable "gw_name" {
  type    = string
  default = "aztransit212-fg"
}


#  Firenet variables

variable "firewall_image" {
  type = string
  default = "Fortinet FortiGate (PAYG_20190624) Next-Generation Firewall Latest Release"
}

#  Set variables with fw1 tokens after accessing
variable "fw1_token" {
  type = string
  default = "test1234"
}

# *tpl apikey read as "Aviatrix123#" including quotes as demonstrated below,  the below worked during TF test
/*
> data.aviatrix_firenet_vendor_integration.fw2.api_token
(sensitive)
> nonsensitive(data.aviatrix_firenet_vendor_integration.fw2.api_token)
"\"Aviatrix123#\""
>
*/


variable "fw1_name" {
  type = string
  default = "azfw1-fg"
}

variable "fw2_name" {
  type = string
  default = "azfw2-fg"
}

variable "fw2_token" {
  type = string
  default = "test1234"
}

# can add hop and name using data resource perhaps
locals {
  fw1 = templatefile("${path.module}/fg-az-bootstrap.tpl", {
    name = var.fw1_name
    hop = "10.212.0.81"
    }
  )
  fw2 = templatefile("${path.module}/fg-az-bootstrap.tpl", {
    name = var.fw2_name
    hop = "10.212.0.129"
    }
  )
}
