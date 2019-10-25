##########################################################
# output 
##########################################################
output "aws_route53_zone" {
  value = "${aws_route53_zone.zone}"
}

output "aws_route53_record" {
  value = "${aws_route53_record.record}"
}

