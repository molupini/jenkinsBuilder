
#########################################################
# resource
#########################################################
resource "aws_security_group" "sg" {
  vpc_id = "${var.vpcId}"

  dynamic "ingress" {
    for_each = [for rule in var.ingressRules : {
    #   from = rule.from_port
    #   to   = rule.to_port
      from = rule
      to   = rule
      type = "tcp"
      security_groups = var.ingressCidrs
    }]

    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.type
      security_groups = ingress.value.security_groups
    }
  }

#   dynamic "egress" {
#     for_each = [for rule in var.egressRules : {
#       from = rule.from_port
#       to   = rule.to_port
#       type = rule.protocol
#       cidr = rule.cidr_blocks
#     }]
# 
#     content {
#       from_port   = egress.value.from
#       to_port     = egress.value.to
#       protocol    = egress.value.type
#       cidr_blocks = egress.value.cidr
#     }
#   }

  tags = "${
    merge("${var.tagging}",
      map(
        "Name", "sgrp-${var.tagging["deploymentId"]}-${var.ingressRules[0]}"
      )
  )}"
}
