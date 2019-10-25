##########################################################
# variables
##########################################################
variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
variable "azs" {
  type    = list(string)
  default = ["a", "b", "c"]
}
variable "privateSubs" {
  type    = list(string)
  default = [1, 2, 3]
}
variable "privateSuffix" {
  type    = string
  default = "int"
}
variable "publicSubs" {
  type    = list(string)
  default = [101, 102, 103]
}
variable "publicSuffix" {
  type    = string
  default = "ext"
}
variable "networkAddress" {
  type    = string
  default = "10.0.0.0/16"
}
variable "id" {
}

#########################################################
# external
#########################################################
data "external" "vpc" {
  program = ["python3", "../../../util/deployment.py", "resources", "${var.id}", "VPC"]
}
data "external" "tagging" {
  program = ["python3", "../../../util/deployment.py", "tagging", "${var.id}"]
}