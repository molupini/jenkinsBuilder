
##########################################################
# output 
##########################################################
output "aws_instance_ec2_sg_id" {
  # value = "${data.aws_instance.ec2.*.vpc_security_group_ids}"
  # value = {
  #     for i in data.aws_instance.ec2:
  #      i.id => i.vpc_security_group_ids
  # }
  value = flatten([
      for i in data.aws_instance.ec2:
       i.vpc_security_group_ids
  ])
}

output "aws_instances_private_ips" {
  value = [
      for ips in data.aws_instances.ec2.private_ips:
       "${ips}/32"
  ]
}

output "aws_instances_public_ips" {
  value = [
      for ips in data.aws_instances.ec2.public_ips:
       "${ips}/32"
  ]
}