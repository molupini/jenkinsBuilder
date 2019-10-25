##########################################################
# variables
##########################################################
variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
variable "ingressCidrs" {
  default = ["0.0.0.0/0"]
}
variable "ingressRules" {
  default = ["mysql-tcp"]
}
# variable "ingressRules" {
#   default = [{
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = "0.0.0.0/0"
#     }
#   ]
# }
# variable "egressRules" {
#   default = [{
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = "0.0.0.0/0"
#     }
#   ]
# }
variable "name" {
}
variable "vpcId" {
}
variable "tags" {
}
