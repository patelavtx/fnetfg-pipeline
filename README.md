#   Test out fnet-fg via pipeline



### terraform.tfvars 

The variables are set during the above pipeline build e.g.
```
# set KV variables
controller-ip = ""
ctrl-password = ""
region       = "West Europe"
account      = ""
transit_gw   = "aztransit184-weu"
attached     = "true"
nat_attached = "true"
ha_gw        = "true"

```
