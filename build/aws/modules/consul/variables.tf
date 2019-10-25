##########################################################
# variables
##########################################################
variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
# variable "id" {
# }
variable "private-key" {
  default = "consul-key"
}
variable "public-key" {
  default = "consul-key.pub"
}

#########################################################
# external
#########################################################

# data "external" "state" {
#   program = ["python3", "../../../util/deployment.py", "resources", "${var.id}", "STATE"]
# }