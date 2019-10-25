##########################################################
# variables
##########################################################
variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
variable "id" {
}
# GET_SUBNET
variable "perimeter" {
  default = "private"
}
# SG
# variable "ingress_rules" {
#   default = ["mysql-tcp"]
# }
# RDS
# variable "rds" {
#   default = {
#     logicalName  = "rds001",
#     dbname       = "demodb",
#     engine       = "mysql",
#     majorRelase  = "5.7",
#     minorRelease = "19",
#     size         = "10",
#     compuTier    = "db.t2.large"
#   }
# }
# BACKUP WINDOW, MIGHT INCLUDE ABOVE 
variable "cidr_rule" {
  type = list(object({
    # logicalName = string
    port        = string
    direction   = string
    source      = string
    forResource = string
    toResource  = string
  }))
}
variable "sg_rule" {
  type = list(object({
    # logicalName = string
    port        = string
    direction   = string
    source      = string
    forResource = string
    toResource  = string
  }))
}

#########################################################
# external
#########################################################
data "external" "vpc" {
  program = ["python3", "../../../util/deployment.py", "resources", "${var.id}", "VPC", "parent"]
}
data "external" "rds" {
  program = ["python3", "../../../util/deployment.py", "resources", "${var.id}", "RDS"]
}
data "external" "sg" {
  program = ["python3", "../../../util/deployment.py", "security", "${var.id}", "resources", "RDS"]
}
data "external" "tagging" {
  program = ["python3", "../../../util/deployment.py", "tagging", "${var.id}"]
}