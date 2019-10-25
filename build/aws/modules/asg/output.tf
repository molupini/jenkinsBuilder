##########################################################
# output 
##########################################################
# DEFAULT
# ASG 
output "asg" {
  value = "${module.asg}"
  depends_on = [
    # aws_instance.ec2
  ]
}
