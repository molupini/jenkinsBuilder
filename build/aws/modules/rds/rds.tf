# GET SUBNETS IDS BASED ON PERIMETER KEY
module "get_subnet" {
  source = "../../get/subnet"

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region     = var.aws_region
  vpcId          = data.external.vpc.result.logicalId
  perimeter      = var.perimeter
  id             = var.id
}

# GET SECURITY GRUOPS BASED ON ID, DEPLOYMENTID
# TODO SG MODULE REQUIRES CIDR RATHER THEN SECURITY GROUP FOR INGRESS CIDR AS THROWING ERROR
# module "get_sg" {
#   source = "../../get/sg"

#   aws_access_key = var.aws_access_key
#   aws_secret_key = var.aws_secret_key
#   aws_region     = var.aws_region
#   # vpcId          = data.external.vpc.result.logicalId
#   id = var.id
# }

# module "get_ec2" {
#   source = "../../get/ec2"

#   aws_access_key = var.aws_access_key
#   aws_secret_key = var.aws_secret_key
#   aws_region     = var.aws_region
#   # vpcId          = data.external.vpc.result.logicalId
#   id = var.id
# }

# module "sg" {
#   source = "../sg"

#   aws_access_key = var.aws_access_key
#   aws_secret_key = var.aws_secret_key
#   aws_region     = var.aws_region

#   # TODO SG MODULE REQUIRES CIDR RATHER THEN SECURITY GROUP FOR INGRESS CIDR AS THROWING ERROR
#   # ingressCidrs = "${module.get_sg.aws_security_group_ids}"
#   ingressCidrs = module.get_ec2.vpc_security_group_ids
#   ingressRules = var.ingress_rules

#   # NAME BELOW CAN DERIVE FROM RDS ENGINE OR NAME 
#   name  = "sgrp-${data.external.tagging.result.deploymentId}-${var.ingress_rules[0]}"
#   vpcId = data.external.vpc.result.logicalId
#   tags  = data.external.tagging.result

# }

# module "sg" {
#   source = "../../custom/sg"

#   # aws_access_key = var.aws_access_key
#   # aws_secret_key = var.aws_secret_key
#   # aws_region     = var.aws_region

#   # TODO SG MODULE REQUIRES CIDR RATHER THEN SECURITY GROUP FOR INGRESS CIDR AS THROWING ERROR
#   # ingressCidrs = "${module.get_sg.aws_security_group_ids}"
#   ingressCidrs = module.get_ec2.aws_instance_ec2_sg_id
#   ingressRules = ["3306"]

#   # NAME BELOW CAN DERIVE FROM RDS ENGINE OR NAME
#   vpcId   = data.external.vpc.result.logicalId
#   tagging = data.external.tagging.result

# }

module "sg_1" {
  source = "../../custom/sg.1"

  # aws_access_key = var.aws_access_key
  # aws_secret_key = var.aws_secret_key
  # aws_region     = var.aws_region

  # TODO SG MODULE REQUIRES CIDR RATHER THEN SECURITY GROUP FOR INGRESS CIDR AS THROWING ERROR
  # ingressCidrs = "${module.get_sg.aws_security_group_ids}"
  cidr_rules = var.cidr_rule
  sg_rules   = var.sg_rule
  # rules = "${data.external.rule.result}"

  # NAME BELOW CAN DERIVE FROM RDS ENGINE OR NAME
  vpcId   = data.external.vpc.result.logicalId
  sg      = data.external.sg.result
  tagging = data.external.tagging.result
}


# TODO ENDING IN POUND # IS REQUIRED VARIABLES 
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.5.0"

  # ID, TYPE, VERSION, STORAGE, TIER
  identifier     = data.external.rds.result.logicalName
  engine         = data.external.rds.result.engine
  engine_version = "${data.external.rds.result.majorRelease}.${data.external.rds.result.minorRelease}"


  instance_class    = data.external.rds.result.compuTier
  allocated_storage = tonumber(data.external.rds.result.size)

  # CRED
  name     = data.external.rds.result.dbname
  username = "root"         #
  password = "CoffeeTea123" #

  # WOULD PREFER TO GET THIS FROM THE PARENT SECURITY GROUP
  # port     = module.sg.aws_security_group_igress[0].from_port #
  port = 3306 #

  # SECUIRTY GROUP 
  vpc_security_group_ids = values(module.sg_1.aws_security_group_id)

  # MAINTENANCE 
  maintenance_window = "Mon:00:00-Mon:03:00" #
  backup_window      = "03:00-06:00"         #

  # TAGS
  # tags = data.external.tagging.result
  tags = "${
    merge("${data.external.tagging.result}",
    map(
      "resourceId", "${data.external.rds.result["resourceId"]}"
    )
  )}"

  # SUBNETS
  subnet_ids = module.get_subnet.aws_subnet_subnet_id

  # TODO IMPORTANT, PARAMS TECH SPECIFIC 
  family               = "${data.external.rds.result.engine}${data.external.rds.result.majorRelease}"
  major_engine_version = "${data.external.rds.result.majorRelease}"

  #### TO ADD INTO VARIABLES AS WELL OR DEFAULT IF NOT SPECIFIED ###
  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]
  #### TO ADD INTO VARIABLES AS WELL OR DEFAULT IF NOT SPECIFIED ###
  # options = [
  #   {
  #     option_name = "MARIADB_AUDIT_PLUGIN"
  #     option_settings = [
  #       {
  #         name  = "SERVER_AUDIT_EVENTS"
  #         value = "CONNECT"
  #       },
  #       {
  #         name  = "SERVER_AUDIT_FILE_ROTATIONS"
  #         value = "37"
  #       },
  #     ]
  #   },
  # ]
}

module "get_rds" {
  source = "../../get/rds"
  name   = data.external.rds.result.logicalName
}
