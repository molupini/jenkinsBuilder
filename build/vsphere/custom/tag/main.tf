
#########################################################
# providers
#########################################################

provider "vsphere" {
  user           = "${var.vsphere_access_key}"
  password       = "${var.vsphere_secret_key}"
  vsphere_server = "${data.external.instance.result["instances"]}"
  # vsphere_server = "${data.external.build.result["vCenter"]}:9443"
  # persist_session = true
  # vim_session_path = "../sessions"
  # rest_session_path = "../rest_sessions"
  
  # If you have a self-signed cert
  allow_unverified_ssl = true
  # alias = "${data.external.build.result["instances"]}"
}

resource "vsphere_tag_category" "category" {
  # provider = "vsphere.${data.external.build.result["instances"]}}"
  count       = "${length(split(",", data.external.keys.result["keys"]))}"
  name        = "${element(split(",", data.external.keys.result["keys"]), count.index)}"
  cardinality = "SINGLE"
  description = "Managed by IaC"

  associable_types = [
    "${data.external.type.result["types"]}"
  ]
}
