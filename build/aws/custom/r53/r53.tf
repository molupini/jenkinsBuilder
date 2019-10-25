#########################################################
# data
#########################################################
data "aws_instances" "ids" {
  filter {
    name = "tag:deploymentId"
    values = [
      "${var.id}"
    ]
  }
}
data "aws_instance" "ec2" {
  count = "${length(tolist(data.aws_instances.ids.ids))}"
  instance_id    = "${data.aws_instances.ids.ids[count.index]}"
}
# data "aws_eip" "eip" {
#   filter {
#     name = "tag:deploymentId"
#     values = [
#       "${var.id}"
#     ]
#   }
# }

#########################################################
# resource
#########################################################
resource "aws_route53_zone" "zone" {
  name = "${var.domain_name}"
}

resource "aws_route53_record" "record" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name    = "${var.entry.name}"
  ttl     = 300
  type    = "${var.entry.type}"
  records = "${data.aws_instance.ec2.*.public_ip}"
}
