# module "sg_1" {
#   source = "../../custom/sg.1"
#   cidr_rules = var.cidr_rule
#   sg_rules   = var.sg_rule
#   vpcId   = data.external.vpc.result.logicalId
#   sg      = data.external.sg.result
#   tagging = data.external.tagging.result
# }

module "asg" {
    
}