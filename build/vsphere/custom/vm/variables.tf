#########################################################
# variables
#########################################################
variable "vsphere_access_key" {
}

variable "vsphere_secret_key" {
}
variable "_id" {
}

#########################################################
# external
#########################################################

data "external" "build" {
  program = ["python3", "../../../util/private/get.py", "build", "${var._id}"]
}

data "external" "tagging" {
  program = ["python3", "../../../util/private/get.py", "tagging", "${var._id}"]
}

