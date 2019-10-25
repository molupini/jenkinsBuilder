##########################################################
# output 
##########################################################

# VERFICATION / STD OUT FOR API UPDATE
# SERVICE WILL REQUIRE APPLICATION, RESOURCE TYPE, DEPLOYMENT ID, LOGICAL ID
# output "application" {
#   value = "${data.external.tagging.result["application"]}"
#   depends_on = [
#     module.get_subnet
#   ]
# }
# output "resourceType" {
#   value = "${data.external.tagging.result["resourceType"]}"
#   depends_on = [
#     module.get_subnet
#   ]
# }
# output "deploymentId" {
#   value = "${data.external.tagging.result["deploymentId"]}"
#   depends_on = [
#     module.get_subnet
#   ]
# }
# output "logicalId" {
#   value = "${module.get_subnet.aws_vpc_vpc.id}"
#   depends_on = [
#     module.get_subnet
#   ]
# }
# output "done" {
#   value = 0
#   depends_on = [
#     module.get_subnet
#   ]
# }

# RESOURCE SPECFIC 

# output "aws_subnet_all" {
#   value = "${module.get_subnet.aws_subnet_all}"
#   depends_on = [
#     module.get_subnet
#   ]
# }
output "aws_subnet_subnet_id" {
  value = "${module.get_subnet.aws_subnet_subnet_id}"
  depends_on = [
    module.get_subnet
  ]
}

output "aws_subnet_subnet_cidr_block" {
  value = "${module.get_subnet.aws_subnet_subnet_cidr_block}"
  depends_on = [
    module.get_subnet
  ]
}

# SG, NOT NEEDED
# output "aws_security_group_ids" {
#   value = "${module.get_sg.aws_security_group_ids}"
#   # depends_on = [
#   #   module.get_sg
#   # ]
# }

# EC2
# output "aws_instance_ec2_sg_id" {
#   value = "${module.get_ec2.aws_instance_ec2_sg_id}"
#   # depends_on = [
#   #   module.get_ec2
#   # ]
# }

# output "aws_instances_private_ips" {
#   value = "${module.get_ec2.aws_instances_private_ips}"
#   # depends_on = [
#   #   module.get_ec2
#   # ]
# }

# output "aws_instances_public_ips" {
#   value = "${module.get_ec2.aws_instances_public_ips}"
#   # depends_on = [
#   #   module.get_ec2
#   # ]
# }

# output "aws_security_group_ids" {
#   value = "${module.sg.aws_security_group_ids}"
#   depends_on = [
#     module.sg
#   ]data.external
# }

# SG
# output "aws_security_group" {
#   value = "${module.sg.aws_security_group}"
#   # depends_on = [
#   #   module.sg
#   # ]
# }
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

# RDS
output "aws_db_instance_rds" {
  value = "${module.get_rds.aws_db_instance_rds}"
  depends_on = [
    # module.rds
  ]
}

output "aws_db_instance_id" {
  value = "${map(data.external.rds.result.resourceId, module.get_rds.aws_db_instance_rds.resource_id)}"
  depends_on = [
    # module.rds
  ]
}

output "rds_resourceId" {
  value = "${data.external.rds.result.resourceId}"
  depends_on = [
    # module.rds
  ]
}