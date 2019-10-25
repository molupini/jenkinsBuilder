##########################################################
# data
##########################################################
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

# MULTIPLY INSTANCES BY VOLUMES TO BALANCE DISTRUBTION 
# USE ELEMENT(LIST, COUNT.INDEX) TO PREVENT OUT OF BOUND ERRORS
# NEED TO TEST WITH UNEVEN EBS OR INSTANCE AMOUNTS TO EVAL THE MATHS PERFORMED BELOW SEE ##
resource "aws_ebs_volume" "ebs" {
  count             = "${length(data.aws_instance.ec2.*.instance_id) * var.ebs_num}"
  size              = "${var.ebs_num != 1 ? element(split(";", var.ebs["size"]), count.index) : var.ebs["size"]}"
  # size              = 1
  encrypted         = false
  type              = "gp2"
  # availability_zone = "${aws_instance.ec2[count.index].availability_zone}"
  ## / THE INSTANCE AZ COUNT BY THE TOTAL OF VOLUMES AND ROUND DOWN, THIS WILL ENSURE THAT DISKS ARE CREATED IN SPECFIC ZONES ALIGNED WITH THE SIMILAR FUNCTION IN ATT RESOURCE
  availability_zone = "${element(data.aws_instance.ec2.*.availability_zone, floor(count.index / var.ebs_num))}"
  tags = "${
    merge("${var.tagging}",
      map(
        "Name", "${var.ebs_num != 1 ? element(split(";", var.ebs["logicalName"]), count.index) : var.ebs["logicalName"]}"
      )
  )}"
}

resource "aws_volume_attachment" "att" {
  count       = "${length(data.aws_instance.ec2.*.instance_id) * var.ebs_num}"
  # count       = length(aws_ebs_volume.ebs.*.id)
  # count       = length(data.aws_instance.ec2.*.instance_id)
  volume_id   = "${element(aws_ebs_volume.ebs.*.id, count.index)}"
  device_name = "${var.ebs_num != 1 ? element(split(";", var.ebs["path"]), count.index) : var.ebs["path"]}"
  
  ## / THE INSTANCE IDS COUNT BY THE TOTAL OF VOLUMES AND ROUND DOWN, THIS WILL ENSURE THAT DISKS ARE CREATED IN SPECFIC ZONES ALIGNED WITH THE SIMILAR FUNCTION IN EBS RESOURCE
  instance_id = "${element(data.aws_instance.ec2.*.instance_id, floor(count.index / var.ebs_num))}"

  # depends_on = [
  #   aws_ebs_volume.ebs
  # ]
} 