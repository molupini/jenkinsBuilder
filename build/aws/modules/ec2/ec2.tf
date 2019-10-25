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

module "ec2" {
  source = "../../custom/ec2"

  # ACCOUNT DETAILS
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region     = var.aws_region

  # VPC 
  vpc = data.external.vpc.result

  # TAGGING
  tagging = data.external.tagging.result

  # DEPLOYMENT ID & COUNT
  id      = var.id
  ec2_num = var.ec2_num

  # PUBLIC KEY FILE
  public_key_file = file("${var.id}-key.pub")

  # SECURITY GROUP FULES
  # TODO NEED TO CREATE IN SEPERATE MODULE 
  # ingress_rule = var.ingressRule
  # egress_rule  = var.egressRule

  # EC2 
  ec2 = data.external.ec2.result

  # DISKS RATHER PROVIDE IN SEPERATE MODULE 
  data_disks = var.dataDisks

  # PRIVATE KEY FILE
  private_key_file = file("${var.id}-key")

  # SG
  sg = values(module.sg_1.aws_security_group_id)
}

module "ebs" {
  source = "../../custom/ebs"

  # ACCOUNT DETAILS
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region     = var.aws_region

  # DEPLOYMENT ID
  id      = var.id
  ebs_num = tonumber(var.ebs_num)

  # EC2 
  ec2 = data.external.ec2.result

  # EBS 
  ebs = data.external.ebs.result

  # TAGGING
  tagging = data.external.tagging.result
}

