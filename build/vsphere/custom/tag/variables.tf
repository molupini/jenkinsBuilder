#########################################################
# variables
#########################################################
variable "vsphere_access_key" {
}

variable "vsphere_secret_key" {
}

#########################################################
# external
#########################################################

data "external" "keys" {
  program = ["python3", "../../../util/private/get.py", "categories", "False", "keys"]
}

data "external" "type" {
  program = ["python3", "../../../util/private/get.py", "categories", "False", "types"]
}

data "external" "instance" {
  program = ["python3", "../../../util/private/get.py", "categories", "False", "instances"]
}

