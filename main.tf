# https://aviatrix.atlassian.net/wiki/spaces/SEA/pages/1779302805/Fortinet
# Bootstrap - https://read.docs.aviatrix.com/HowTos/fortigate_bootstrap_example_azure.html


# (A)  Transit + firenet
module "mc_transit" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version                = "v2.5.3"
  cloud                  = "Azure"
  cidr                   = "10.212.0.0/20"
  region                 = var.azure_region
  account                = var.azure_account
  enable_transit_firenet = true
  instance_size          = "Standard_B2ms"           # beware of size requirement for insane + firenet
  name                   = "aztransit212"            # sets vnet name
  gw_name                = var.gw_name        # sets gw name
  ha_gw                  = var.ha_gw
  resource_group = "atulrg-customiam"               # If using SP at RG level
}


/*
module "firenet_1" {
  source         = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version        = "1.5.0"
  transit_module = module.mc_transit
  firewall_image = var.firewall_image
  # firewall_image_version = "R80.40-294.991001266"                                             #  specific version  ; otherwise latest used  firewall_image_id or this setting not BOTH
  #firewall_image_id  = "fortinet:fortinet_fortigate-vm_v5:fortinet_fg-vm_payg_2022:7.0.9"      # if not listed in controller gui;  ONLY aws currently supported
  #fw_amount = "0"                                                                              # not deploy ngfw
  egress_enabled     = true # default is false
  inspection_enabled = true # default is true
  #custom_fw_names    = [var.fw1_name, var.fw2_name]
  custom_fw_names     =  [var.fw1_name]
  #instance_size      = var.instance_size               # default is Standard_D3_v2
  #username = "fwadmin"                                 # default creds in Azure only
  #password = "Aviatrix1234"
  user_data_1    = local.fw1
  #user_data_2    = local.fw2
}

# added delay to allow fw interfaces to be ready for vendor integration
resource "time_sleep" "wait_90_seconds" {
  create_duration = "90s"
  depends_on = [ module.firenet_1 ]
}

# (C) api token needed for FG
data "aviatrix_firenet_vendor_integration" "fw1" {
  vpc_id        = module.mc_transit.transit_gateway.vpc_id
  instance_id   = module.firenet_1.aviatrix_firewall_instance[0].instance_id
  vendor_type   = "Fortinet FortiGate"                                      # "Generic", "Palo Alto Networks VM-Series", "Aviatrix FQDN Gateway" and "Fortinet FortiGate"
  public_ip     = module.firenet_1.aviatrix_firewall_instance[0].public_ip
  #username      = "fwadmin"                                                # REST_API user or admin for PA
  #password      = module.firenet_1.aviatrix_firewall_instance[0].password
  username      = "apiadmin"
  api_token     = var.fw1_token                                    # Fortigate REST_API user token for FW1
  firewall_name = module.firenet_1.aviatrix_firewall_instance[0].firewall_name
  #save          = true                                            #  Get error on saving vendor info - permissions?
  #synchronize   = true # "save" and "synchronize" cannot be invoked at the same time
  depends_on = [ time_sleep.wait_90_seconds ]

}
*/
