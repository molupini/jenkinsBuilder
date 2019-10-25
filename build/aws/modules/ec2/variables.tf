##########################################################
# variables
##########################################################
variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "aws_region" {
}

# TODO SEED SECURITY GROUP CONFIGURATION VIA API

# # These are for internal traffic
# ingress {
#     from_port = 0
#     to_port = 65535
#     protocol = "tcp"
#     self = true
# }

# ingress {
#     from_port = 0
#     to_port = 65535
#     protocol = "udp"
#     self = true
# }

# variable "ingressRule" {
#   default = [
#     {
#       from_port   = 22
#       to_port     = 22
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     },
#     {
#       from_port   = 80
#       to_port     = 80
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     },
#   ]
# }

# variable "egressRule" {
#   default = [
#     {
#       from_port   = 80
#       to_port     = 80
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     },
#   ]
# }

# SEE RECOMMENDED VOLUME DEVICE NAMES
# xvd[f-p]
# RATHER USE SEPERATE MODULES TO ATTACH WHICH MAKE INFRA IMMUTABLE 
variable "dataDisks" {
  default = []
  # default = [
  #   {
  #     device_name           = "/dev/sdf"
  #     volume_type           = "gp2"
  #     volume_size           = 16
  #     delete_on_termination = true
  #     encrypted             = false
  #   }
  # ,
  # {
  #   device_name           = "/dev/sdg"
  #   volume_type           = "gp2"
  #   volume_size           = 16
  #   delete_on_termination = true
  #   encrypted             = false
  # }
  #]
}

variable "id" {
}

variable "ec2_num" {
}

variable "ebs_num" {
}

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
  program = ["python3", "../../../util/deployment.py", "resources", var.id, "VPC", "parent"]
}

data "external" "ec2" {
  program = ["python3", "../../../util/deployment.py", "resources", var.id, "EC2"]
}

data "external" "ebs" {
  program = ["python3", "../../../util/deployment.py", "resources", var.id, "EBS"]
}

data "external" "sg" {
  program = ["python3", "../../../util/deployment.py", "security", "${var.id}", "resources", "EC2"]
}

data "external" "tagging" {
  program = ["python3", "../../../util/deployment.py", "tagging", var.id]
}

