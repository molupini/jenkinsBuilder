##########################################################
# variables
##########################################################
variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
variable "vpcId" {
}
variable "perimeter" {
    default = "default"
}
variable "id" {
}

#########################################################
# external
#########################################################
data "external" "perimeter" {
  program = ["python3", "../../../util/deployment.py", "perimeter", "${var.id}"]
}