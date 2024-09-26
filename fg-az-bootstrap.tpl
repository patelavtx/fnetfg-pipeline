# Simple Example Fortigate Bootstrap Configuration
# Not Necessary Fulfill the Requirement for any Customer

# Login Username and Password
config system admin
    edit admin
        set password Aviatrix123#
    next
end

# System Hostname
config system global
    set hostname atulfortigate
    set timezone 01
end

config system accprofile
   edit "apiprofile"
        set secfabgrp {none}
        set ftviewgrp {read-write}
        set authgrp {none}
        set sysgrp {read-write}
        set netgrp {read-write}
        set loggrp {none}
        set fwgrp {none}
        set vpngrp {none}
        set utmgrp {none}
        set wanoptgrp {none}
        set wifi {none}
        set admintimeout-override {disable}
        set system-diagnostics {disable}
    next
end

config system api-user
   edit "apiadmin"
        set api-key enable
        set api-key "Aviatrix123#"
        set accprofile "apiprofile"
        set vdom "root"
    next
end

# System Hostname
config system global
    set hostname ${name}
    set timezone 25
end

# Important HTTPS needs to be allowed on LAN interface for Firewall Health Check
config system interface
    edit port2
        set allowaccess https
    next
end

#RFC 1918 Routes and Subnet Default Gateway
config router static
    edit 1
        set dst 10.0.0.0 255.0.0.0
        set gateway ${hop}
        set device port2
    next
    edit 2
        set dst 192.168.0.0 255.255.0.0
        set gateway ${hop}
        set device port2
    next
    edit 3
        set dst 172.16.0.0 255.240.0.0
        set gateway ${hop}
        set device port2
    next
    # LoadBalancer IP
    edit 4
        set dst 168.63.129.16 255.255.255.255
        set gateway ${hop}
        set device port2
    next
end

# Firewall Allow All Policy Example
config firewall policy
    edit 1
        set name allow_all
        set srcintf port2
        set dstintf port2
        set srcaddr all
        set dstaddr all
        set action accept
        set schedule always
        set service ALL
    next
end