##########################################################
# output 
##########################################################

# TESTING
output "aws_ebs_volume" {
  value = aws_ebs_volume.ebs
}

output "aws_volume_attachment" {
  value = aws_volume_attachment.att
}

# VERFICATION
# output "application" {
#   value = "${data.external.tagging.result["application"]}"
# }
# output "deploymentId" {
#   value = "${data.external.tagging.result["deploymentId"]}"
# }
# output "done" {
#   value = 0
#   depends_on = [
#     aws_volume_attachment.att
#   ]
# }

# # RESOURCE SPECFIC 
# output "aws_volume_attachment" {
#   value = "${aws_volume_attachment.att}"
# }
# output "aws_ebs_volume" {
#   value = "${aws_ebs_volume.ebs}"
# }


