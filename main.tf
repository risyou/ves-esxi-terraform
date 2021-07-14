terraform {
  required_version = ">= 0.12"
}

provider "esxi" {
  esxi_hostname      = var.esxi["hostname"]
  esxi_hostport      = var.esxi["hostport"]
  esxi_hostssl       = var.esxi["hostssl"]
  esxi_username      = var.esxi["username"]
  esxi_password      = var.esxi["password"]
}

resource "esxi_guest" "volterra" {

  for_each           = toset(var.volterra["node_name"])
  guest_name         = format("%s-%s",var.volterra["cluster_name"], each.value)

  disk_store         = var.vm["datastore"]
  ovf_source         = var.vm["ovf_file"]
  numvcpus           = var.vm["numvcpus"]
  memsize            = var.vm["memsize"]
  #boot_disk_size     = var.vm["disksize"]
  power              = var.vm["power"]
  network_interfaces {
    virtual_network = var.vm["virtual_network"]
  }

## Volterra ova property

  ovf_properties {
    key              = "guestinfo.hostname"
    value            = format("%s-%s",var.volterra["cluster_name"], each.value)
  }

  ovf_properties {
    key   = "guestinfo.ves.token"
    value = var.volterra["token"]
  }

  ovf_properties {
    key   = "guestinfo.ves.clustername"
    value = var.volterra["cluster_name"]
  }

  ovf_properties {
    key   = "guestinfo.interface.0.ip.0.address"
    value = var.volterra["ip_address"]
  }

  ovf_properties {
    key   = "guestinfo.interface.0.ip.0.gateway"
    value = var.volterra["gateway"]
  }

  ovf_properties {
    key   = "guestinfo.dns.server.0"
    value = var.volterra["dns1"]
  }
  ovf_properties {
    key   = "guestinfo.dns.server.1"
    value = var.volterra["dns2"]
  }
  ovf_properties {
    key   = "guestinfo.ves.regurl"
    value = var.volterra.regurl[0]
  }
  ovf_properties {
    key   = "guestinfo.ves.certifiedhardware"
    value = var.volterra.hw[0]
  }
  ovf_properties {
    key   = "guestinfo.ves.latitude"
    value = var.volterra["latitude"]
  }
  ovf_properties {
    key   = "guestinfo.ves.longitude"
    value = var.volterra["longitude"]
  }
  ovf_properties_timer   = 150
}
