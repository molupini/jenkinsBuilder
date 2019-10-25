##########################################################
# output 
##########################################################
# TESTING VPC OUTPUT
output "aws_security_group_id" {
  value = "${aws_security_group.sg.id}"
}
output "aws_security_group_igress" {
  value = "${aws_security_group.sg.ingress}"
}
output "sg_igress_from_port" {
  value = "${aws_security_group.sg.ingress.*.from_port}"
}