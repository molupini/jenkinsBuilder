#########################################################
# providers
#########################################################

provider "vsphere" {
  user           = "${var.vsphere_access_key}"
  password       = "${var.vsphere_secret_key}"
  vsphere_server = "${data.external.build.result["vCenter"]}"
  # vsphere_server = "${data.external.build.result["vCenter"]}:9443"
  # persist_session = true
  # vim_session_path = "../sessions"
  # rest_session_path = "../rest_sessions"
  
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

#########################################################
# data
#########################################################

# declare the datasource 
data "vsphere_datacenter" "dc" {
  name = "${data.external.build.result["dataCenterName"]}"
}

data "vsphere_datastore" "datastore" {
  name          = "${data.external.build.result["dataStoreName"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${data.external.build.result["clusterName"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# data "vsphere_network" "network" {
#   name          = "${data.external.build.result["networkName"]}"
#   datacenter_id = "${data.vsphere_datacenter.dc.id}"
# }

data "vsphere_virtual_machine" "template" {
  name          = "${data.external.build.result["template"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# data "vsphere_tag_category" "category" {
# }

#########################################################
# resources
#########################################################

# resource "vsphere_tag" "tag" {
#   count = "${length(data.external.tagging.result)}"
#   name  = "${element(data.external.tagging.result, count.index)}"
#   # category_id = "${map(data.external.tagging.result, "${element(keys(data.external.tagging.result), count.index)}")}"
#   description = "Managed by Terraform"
# }

resource "vsphere_virtual_machine" "vm" {
  
  # count   = "${length(data.external.build.result)}"

  name             = "${element(split(".", data.external.build.result["fqdn"]), 0)}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  
  # TODO ENV_VAR$$
  wait_for_guest_net_timeout = 15

  num_cpus = "${data.external.build.result["processorCount"]}"
  memory   = "${data.external.build.result["memoryMBCount"]}"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    # network_id   = "${data.vsphere_network.network.id}"
    network_id   = "${data.external.build.result["networkId"]}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label = "boot_0"
    size  = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  dynamic "disk" {
    for_each  = [for d in split(",", data.external.build.result["dataDisks"]) : {
      label   = "dat_${element(split(":", d), 0)}"
      size    = "${element(split(":", d), 1)}"
      num     = "${element(split(":", d), 0)}"
    }]

    content {
      label       = disk.value.label
      size        = disk.value.size
      unit_number = disk.value.num
    }
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    customize {

      windows_options {
        computer_name = "${element(split(".", data.external.build.result["fqdn"]), 0)}"
        # TODO ENV_VAR
        admin_password = "VMw4re123"
        # join_domain    = "test.internal"
        # domain_admin_user = "admin"
        # domain_admin_password = "pass"
        # full_name = "${element(split(",", data.external.tagging.result["name"]), 0)}"
        organization_name = "${data.external.tagging.result["tenant"]}"
        # workgroup = "sandbox"
        auto_logon = true
        # auto_logon_count = 1
        # add to config api 
        # https://docs.microsoft.com/en-us/previous-versions/windows/embedded/ms912391(v=winembedded.11)
        time_zone = 140
      }

      network_interface {
        ipv4_address = "${data.external.build.result["address"]}"
        ipv4_netmask = "${data.external.build.result["subnetMaskLength"]}"
        dns_server_list = ["${data.external.build.result["dnsA"]}", "${data.external.build.result["dnsB"]}"]
      }
      
      ipv4_gateway = "${data.external.build.result["defaultGateway"]}"
    }
  }
}

