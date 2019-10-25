
#########################################################
# resource
#########################################################

resource "aws_security_group" "sg" {
  vpc_id = "${var.vpcId}"

  # dynamic "ingress" {
  #   for_each = "${var.rules}"
  #   content {
  #     # from_port = if var.direction == "ingress" ? ingress.value.port : ""
  #     from_port   = "${ingress.value.port}"
  #     to_port     = "${ingress.value.port}"
  #     protocol    = "tcp"
  #     cidr_blocks = ["${ingress.value.source}"]
  #   }    
  # }
  # "${merge("${var.tagging}", map())}"
  # tags = "${merge("${var.tagging}", map("Name", var.name))}"
  # dynamic "tag" {
  #   for_each = "${var.rules}"
  #   content {
  #     key     = "Name"
  #     value   = tag.value.logicalName
  #   }
  # }
  tags = "${
  merge("${var.tagging}",
    map(
      "Name", "${var.sg["logicalName"]}",
      "resourceId", "${var.sg["resourceId"]}"
    )
)}"
}

resource "aws_security_group_rule" "cidr_rules" {
  count       = "${length(var.cidr_rules)}"

  type        = "${lookup(element(var.cidr_rules, count.index), "direction")}"
  from_port   = "${lookup(element(var.cidr_rules, count.index), "port")}"
  to_port     = "${lookup(element(var.cidr_rules, count.index), "port")}"
  protocol    = "tcp"
  cidr_blocks = ["${lookup(element(var.cidr_rules, count.index), "source")}"]

  security_group_id = "${aws_security_group.sg.id}"

}

resource "aws_security_group_rule" "sg_rules" {
  count       = "${length(var.sg_rules)}"

  type        = "${lookup(element(var.sg_rules, count.index), "direction")}"
  from_port   = "${lookup(element(var.sg_rules, count.index), "port")}"
  to_port     = "${lookup(element(var.sg_rules, count.index), "port")}"
  protocol    = "tcp"
  source_security_group_id = "${lookup(element(var.sg_rules, count.index), "source")}"

  security_group_id = "${aws_security_group.sg.id}"

}

  # dynamic "ingress" {
  #   for_each = [for rule in var.rules : {
  #   #   from = rule.from_port
  #   #   to   = rule.to_port
  #   # if rule.direction = "ingress"
  #     from = rule.port
  #     to   = rule.port
  #     type = "tcp"
  #     cidr = rule.source
  #     # name = rule.logicalName
  #     # security_groups = rule.source
  #   }]

  #   content {
  #     from_port   = ingress.value.from
  #     to_port     = ingress.value.to
  #     protocol    = ingress.value.type
  #     cidr_blocks = ingress.value.cidr
  #     # security_groups = ingress.value.security_groups
  #   }
  # }
  # dynamic "egress" {
  #   for_each = var.rules
  #   content {
  #     from_port = ingress.value.port
  #     to_port     = ingress.value.port
  #     protocol    = "tcp"
  #     cidr_blocks = [ingress.value.source]
  #   }
  # }
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

