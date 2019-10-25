
#########################################################
# modules
#########################################################
# TODO NEED TO PARAM SETTINGS BELOW SEE, SECURITY GROUP INGRESS RULE AND EGRESS RULE
# SEE, https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/3.1.0 

module "sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "3.1.0"

  name   = "${var.name}"
  vpc_id = "${var.vpcId}"

  # MORE COMPLEX 
  # ingress_with_cidr_blocks = "${var.ingressRules}"
  
  # VARIABLE NO IN ROOT 
  # egress_with_cidr_blocks  = "${var.egressRules}"
  
  # WORKS WITH CIDR NOT SG, BELOW COMPLEX RATHER USE CUSTOM SG INSTEAD
  ingress_cidr_blocks     = "${var.ingressCidrs}"
  ingress_rules           = "${var.ingressRules}"

  # WORKS WITH SG, HOWEVER WOULD SUGGEST USING CUSTOM SG INSTEAD 
  # computed_ingress_with_source_security_group_id = [
  #   {
  #     rule                     = "${var.ingressRules[0]}"
  #     source_security_group_id = "${var.ingressCidrs[0]}"
  #   }
  # ]
  

  tags = "${var.tags}"
}
