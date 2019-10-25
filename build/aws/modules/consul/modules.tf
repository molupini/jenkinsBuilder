##########################################################
# modules
##########################################################
module "consul" {
    source      = "github.com/wardviaene/terraform-consul-module"
    key_name    = "${aws_key_pair.key.key_name}"
    key_path    = "${file("${var.private-key}")}"
    vpc_id      = data.aws_vpc.vpc.id
    subnets     = "${zipmap(data.aws_subnet.subnet.*.tags.Name, data.aws_subnet.subnet.*.id)}"
    # tags = ""
}
