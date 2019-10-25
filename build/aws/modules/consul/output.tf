##########################################################
# output 
# ##########################################################
# output "consul-output" {
#   value = "${module.consul.server_address}"

# TODO, TEST OUTPUT 
# }
output "aws_subnet-output" {
  value = ["${zipmap(data.aws_subnet.subnet.*.tags.Name, data.aws_subnet.subnet.*.id)}"]
}
output "aws_subnet_ids-output" {
  value = "${data.aws_subnet_ids.subnet}"
}

