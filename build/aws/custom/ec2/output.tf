##########################################################
# output 
##########################################################
output "ec2_resourceId" {
  value = "${var.ec2.resourceId}"
  depends_on = [
    # aws_instance.ec2
  ]
}

output "aws_instance_id" {
  value = "${zipmap(aws_instance.ec2.*.tags.resourceId, aws_instance.ec2.*.id)}"
  depends_on = [
    aws_instance.ec2
  ]
}

output "aws_instance_private_dns" {
  value = zipmap(aws_instance.ec2.*.tags.Name, aws_instance.ec2.*.private_dns)
  depends_on = [
    aws_instance.ec2
  ]
}

output "aws_instance_private_ip" {
  value = zipmap(aws_instance.ec2.*.tags.Name, aws_instance.ec2.*.private_ip)
  depends_on = [
    aws_instance.ec2
  ]
}

output "aws_instance_public_dns" {
  value = zipmap(aws_instance.ec2.*.tags.Name, aws_instance.ec2.*.public_dns)
  depends_on = [
    aws_instance.ec2
  ]
}

output "aws_instance_public_ip" {
  value = zipmap(aws_instance.ec2.*.tags.Name, aws_instance.ec2.*.public_ip)
  depends_on = [
    aws_instance.ec2
  ]
}

output "aws_instance_aZ" {
  value = zipmap(aws_instance.ec2.*.tags.Name, aws_instance.ec2.*.availability_zone)
  depends_on = [
    aws_instance.ec2
  ]
}

output "aws_eip" {
  value = zipmap(aws_eip.eip.*.tags.Name, aws_eip.eip.*.public_ip)
  depends_on = [
    aws_instance.ec2
  ]
}



# PROVIDE KEY TO END-USER
# output "aws_key_pair" {
#   value = [
#     "${aws_key_pair.generated_key}"
#   ]
#   depends_on = [
#     aws_key_pair.generated_key
#   ]
# }

