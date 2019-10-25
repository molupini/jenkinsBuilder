##########################################################
# data  
# ##########################################################
data "aws_vpc" "vpc" {
  id = "${var.vpc["logicalId"]}"
}

# # TODO NEED TO REFERENCE SEEDED SUBNETS RATHER THEN BELOW AS COULD RESULT IN NULL DATA 
data "aws_subnet_ids" "subnet" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  filter {
    name = "tag:Name"
    values = [
      "*-${lower(var.tagging.perimeters)}-*",
      "*-${upper(var.tagging.perimeters)}-*"
    ]
  }
}

data "aws_subnet" "subnet" {
  # for_each attribute for creating multiple resources based on a map #17179
  # for_each = data.aws_subnet_ids.subnet.ids
  # id = each.value
  count = "${length(tolist(data.aws_subnet_ids.subnet.ids))}"
  id    = "${tolist(data.aws_subnet_ids.subnet.ids)[count.index]}"
}

#########################################################
# resource
#########################################################
resource "aws_key_pair" "generated_key" {
  key_name   = "${var.id}-key"
  public_key = "${var.public_key_file}"
}

# resource "aws_security_group" "sg" {
#   vpc_id = "${data.aws_vpc.vpc.id}"

#   dynamic "ingress" {
#     for_each = [for rule in var.ingress_rule : {
#       from = rule.from_port
#       to   = rule.to_port
#       type = rule.protocol
#       cidr = rule.cidr_blocks
#     }]

#     content {
#       from_port   = ingress.value.from
#       to_port     = ingress.value.to
#       protocol    = ingress.value.type
#       cidr_blocks = ingress.value.cidr
#     }
#   }

#   dynamic "egress" {
#     for_each = [for rule in var.egress_rule : {
#       from = rule.from_port
#       to   = rule.to_port
#       type = rule.protocol
#       cidr = rule.cidr_blocks
#     }]

#     content {
#       from_port   = egress.value.from
#       to_port     = egress.value.to
#       protocol    = egress.value.type
#       cidr_blocks = egress.value.cidr
#     }
#   }

#   tags = "${
#     merge("${var.tagging}",
#       map(
#         "Name", "sgrp-${var.tagging["deploymentId"]}"
#       )
#   )}"
# }

resource "aws_instance" "ec2" {
  # TODO VERIFY BREAKING CHANGE WITHIN TERRAFORM 0.12
  # COUNT PARAM CAN ONLY BE USED DIRECTLY WITH A DATA RESOURCE 
  # https://github.com/hashicorp/terraform/issues/12570#issuecomment-318414280
  count = "${var.ec2_num}"
  # count = regex(data.external.ec2.result["logicalName"], ";" ) ? split(";", data.external.ec2.result["logicalName"])[count.index] : data.external.ec2.result["logicalName"]
  # for_each = "${var.ec2["logicalName"]}"

  ami           = "${var.ec2["template"]}"
  instance_type = "${var.ec2["compuTier"]}"
  key_name      = "${aws_key_pair.generated_key.key_name}"
  # subnet_id     = "${data.aws_subnet.subnet.*.id[count.index]}"
  subnet_id     = "${element(data.aws_subnet.subnet.*.id, count.index)}"

  security_groups = "${var.sg}"

  # TODO EVAL IF BETTER TO RATHER USE aws_ebs_volume and aws_volume_attachment RESOURCE
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nvme-ebs-volumes.html 
  # dynamic "ebs_block_device" {
  #   for_each = [for drive in var.data_disks : {
  #     device  = drive.device_name
  #     type    = drive.volume_type
  #     keep    = drive.delete_on_termination
  #     encrypt = drive.encrypted
  #   }]

  #   content {
  #     device_name           = ebs_block_device.value.device
  #     volume_type           = ebs_block_device.value.type
  #     delete_on_termination = ebs_block_device.value.keep
  #     encrypted             = ebs_block_device.value.encrypt
  #   }
  # }

  tags = "${
    merge("${var.tagging}",
      map(
        "Name", "${var.ec2_num != 1 ? element(split(";", var.ec2["logicalName"]), count.index) : var.ec2["logicalName"]}",
        "resourceId", "${var.ec2_num != 1 ? element(split(";", var.ec2["resourceId"]), count.index) : var.ec2["resourceId"]}"
      )
  )}"

  # TODO WILL NEED TO SPECIFY IF TO CONNECT VIA PUBLIC IP OR PRIVATE 
  # TODO POST CONFIGURATION MANAGEMENT
  # TODO BEST TO PROVIDE A SEPERATE SERVICE 
  # TODO EVAL USER DATA RATHER
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt update",
  #     "sudo apt install nginx -y"
  #   ]
  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     host        = "${self.public_ip}"
  #     private_key = "${var.private_key_file}"
  #   }
  # }
  user_data = "#!/bin/bash\nsudo apt update\nsudo apt install nginx -y\n"
}

# TODO EVAL THE OUTCOME OF USING A NON PUBLIC INSSTANCE 
resource "aws_eip" "eip" {
  count     = length(aws_instance.ec2.*.public_dns) >= 1 ? length(aws_instance.ec2.*.public_dns) : 0
  instance  = aws_instance.ec2.*.id[count.index]
  vpc       = true
  tags  = "${
  merge("${var.tagging}",
    map(
      "Name", "${var.ec2_num != 1 ? "eipa-${element(split(";", var.ec2["logicalName"]), count.index)}" : var.ec2["logicalName"]}"
    )
  )}"
  depends_on = [
    aws_instance.ec2
  ]
}
