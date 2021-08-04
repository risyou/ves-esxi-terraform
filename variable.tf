variable "volterra" {
  default = {
    token         = "thisisyourtokenaaaabbbb"
    #hostname (auto)  ==  $(cluster_name)-$(node_name), for example, shali-c12-master-0
    cluster_name  = "shali-c12"
    #Specify the node list you want to create
    node_name = [
      "master-0",
      "master-1",
      "master-2",
      "worker-0"
    ]
    #Leave IP/Gateway/DNS blank to get from DHCP
    ip_address = [
      "192.168.200.110/24",
      "192.168.200.111/24",
      "192.168.200.112/24",
      "192.168.200.113/24"
      ]
    gateway    = "192.168.200.1"
    dns1       = "8.8.8.8"
    dns2       = "8.8.4.4"
    #main.tf take from the index[0], put what you want to use in index[0] for below parameter
    regurl     = ["ves.volterra.io","ves.volterra.io","staging.volterra.us"]
    hw         = ["vmware-voltstack-combo","vmware-voltstack-combo","vmware-voltmesh", "vmware-multi-nic-voltmesh", "vmware-multi-nic-voltstack-combo"]
    latitude   = "35.6743109"
    longitude  = "139.7314718"
  }
}



variable "vm" {
  default   = {
    ovf_file        =  "/tmp/centos-7.2006.3-202105241147.ova"
    #vmname         = var.volterra["hostname"]
    virtual_network = "c3560-vlan201-192-168-201-dhcp"  #ESXi_Portgroup name
    datastore       = "datastore1"
    numvcpus        = "4"
    memsize         = "8192" #8192 16384   32768
    power           = "on"
    }
}

variable "esxi" {
  default = {
    hostname  = "192.168.100.1"
    username  = "root"
    password  = "password"
    hostport  = "22"
    hostssl   = "443"
  }
}
