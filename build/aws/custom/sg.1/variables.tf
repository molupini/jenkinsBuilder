##########################################################
# variables
##########################################################
variable "vpcId" {
}
variable "tagging" {
}
variable "sg" {
}
variable "cidr_rules" {
    type = list(object({
        # logicalName = string
        port        = string
        direction   = string
        source      = string
        forResource = string
        toResource  = string
  }))
}
variable "sg_rules" {
    type = list(object({
        # logicalName = string
        port        = string
        direction   = string
        source      = string
        forResource = string
        toResource  = string
  }))
}
