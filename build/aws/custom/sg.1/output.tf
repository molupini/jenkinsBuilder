##########################################################
# output 
##########################################################
# TESTING VPC OUTPUT
# output "aws_security_group_id" {
#   value = "${aws_security_group.sg.id}"
# }
output "aws_security_group_id" {
  value = "${zipmap(aws_security_group.sg.*.tags.resourceId, aws_security_group.sg.*.id)}"
}
output "sg_resourceId" {
  value = "${var.sg.resourceId}"
}
output "aws_security_group_rule_cidr_rules" {
  value = "${aws_security_group_rule.cidr_rules}"
}
output "aws_security_group_rule_sg_rules" {
  value = "${aws_security_group_rule.sg_rules}"
}