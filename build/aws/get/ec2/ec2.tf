#########################################################
# resources
#########################################################

data "aws_instances" "ec2" {
  # vpc_id = "${data.aws_vpc.vpc.id}"
  instance_tags = {
    deploymentId = "${var.id}"
  }
}

data "aws_instance" "ec2" {
  # vpc_id = "${data.aws_vpc.vpc.id}"
  # instance_tags = {
  #   deploymentId = "${var.id}"
  # }
  count = "${length(data.aws_instances.ec2.*.ids)}"
  instance_id = "${data.aws_instances.ec2.ids[count.index]}"
}

