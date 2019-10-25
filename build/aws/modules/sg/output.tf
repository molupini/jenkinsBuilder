##########################################################
# output 
##########################################################
# TESTING VPC OUTPUT
output "aws_security_group" {
  value = "${module.sg}"
}