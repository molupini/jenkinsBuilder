#########################################################
# resources
#########################################################
# data "aws_vpc" "vpc" {
#   id = "${var.vpcId}"
# }

# DO NOT REQUIRE AS BELOW ALLOWS FOR FILTER BASED ON TAG DEPLOYMENTID
# data "aws_security_groups" "sg" {
#   # vpc_id = "${data.aws_vpc.vpc.id}"
#   tags = {
#     deploymentId = "${var.id}"
#   }
# }

data "aws_security_group" "sg" {
  # vpc_id = "${data.aws_vpc.vpc.id}"
  tags = {
    deploymentId = "${var.id}"
  }
}

