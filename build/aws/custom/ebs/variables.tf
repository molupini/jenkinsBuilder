variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
# https://www.terraform.io/docs/providers/aws/r/volume_attachment.html
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html#available-ec2-device-names
# variable "dataDisk" {
#   default = [
#     # {
#     #   "dev/sdg" = "1"
#     # }
#     # ,
#     {
#       instance = "i-036375354621a0210"
#       aZ       = "eu-west-1a"
#       name     = "/dev/sdf"
#       type     = "gp2"
#       size     = 1
#       delete   = false
#       encrypt  = false
#     },
#     {
#       instance = "i-036375354621a0210"
#       aZ       = "eu-west-1a"
#       name     = "/dev/sdg"
#       type     = "gp2"
#       size     = 1
#       delete   = false
#       encrypt  = false
#     }
#   ]
# }
variable "id" {
}
variable "ebs_num" {
}
variable "ec2" {
}
variable "ebs" {
}
variable "tagging" {
}