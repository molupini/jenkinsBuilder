#########################################################
# resource
# #########################################################
data "aws_vpc" "vpc" {
  id = "vpc-0cd38f1d32feec38f"
}

data "aws_subnet_ids" "subnet" {
  vpc_id = "${data.aws_vpc.vpc.id}"
}

data "aws_subnet" "subnet" {
  # for_each attribute for creating multiple resources based on a map #17179
  # for_each = data.aws_subnet_ids.subnet.ids
  # id = each.value
  count = "${length(tolist(data.aws_subnet_ids.subnet.ids))}"
  id    = "${tolist(data.aws_subnet_ids.subnet.ids)[count.index]}"
}

resource "aws_key_pair" "key" {
  # name = "${var.public-key}"
  public_key = "${file("${var.public-key}")}"
}

