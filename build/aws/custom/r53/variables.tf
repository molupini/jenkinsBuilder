##########################################################
# variables
##########################################################
variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
variable "domain_name" {
  default = "mauriziolupini.co.za"
}
variable "entry" {
  default = {
    name = "www.mauriziolupini.co.za"
    type = "A"
  }
}
variable "id" {
}
