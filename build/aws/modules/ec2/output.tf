##########################################################
# output 
##########################################################
# DEFAULT
output "application" {
  value      = data.external.tagging.result["application"]
  depends_on = []
  # aws_instance.ec2
}

output "resourceType" {
  value      = data.external.tagging.result["resourceType"]
  depends_on = []
  # aws_instance.ec2
}

output "deploymentId" {
  value      = data.external.tagging.result["deploymentId"]
  depends_on = []
  # aws_instance.ec2
}

output "done" {
  value      = 0
  depends_on = []
  # aws_instance.ec2
}

# SG
output "sg_resourceId" {
  value = "${module.sg_1.sg_resourceId}"
}

output "aws_security_group_id" {
  value      = module.sg_1.aws_security_group_id
  depends_on = []
  # aws_instance.ec2
}

output "aws_security_group_rule_cidr_rules" {
  value      = module.sg_1.aws_security_group_rule_cidr_rules
  depends_on = []
  # aws_instance.ec2
}

output "aws_security_group_rule_sg_rules" {
  value      = module.sg_1.aws_security_group_rule_sg_rules
  depends_on = []
  # aws_instance.ec2
}

# EC2 
output "ec2_resourceId" {
  value = "${module.ec2.ec2_resourceId}"
  depends_on = [
    # aws_instance.ec2
  ]
}

output "aws_instance_id" {
  value      = module.ec2.aws_instance_id
  depends_on = []
  # aws_instance.ec2
}

output "aws_instance_private_dns" {
  value      = module.ec2.aws_instance_private_dns
  depends_on = []
  # aws_instance.ec2
}

output "aws_instance_private_ip" {
  value      = module.ec2.aws_instance_private_ip
  depends_on = []
  # aws_instance.ec2
}

output "aws_instance_public_dns" {
  value      = module.ec2.aws_instance_public_dns
  depends_on = []
  # aws_instance.ec2
}

output "aws_instance_public_ip" {
  value      = module.ec2.aws_instance_public_ip
  depends_on = []
  # aws_instance.ec2
}

output "aws_instance_aZ" {
  value      = module.ec2.aws_instance_aZ
  depends_on = []
  # aws_instance.ec2
}

output "aws_eip" {
  value      = module.ec2.aws_eip
  depends_on = []
  # aws_eip.eip
}

# EBS
# output "ebs" {
#   value = module.ebs
#   depends_on = [
#     module.ebs
#   ]
# }

# EBS
output "aws_ebs_volume" {
  value      = module.ebs.aws_ebs_volume
  depends_on = []
  # aws_ebs_volume.ebs
}

output "aws_volume_attachment" {
  value      = module.ebs.aws_volume_attachment
  depends_on = []
  # aws_volume_attachment.att
}

