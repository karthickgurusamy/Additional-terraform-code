resource "aws_instance" "server-1" {
 ami = "ami-006dcf34c09e50022"
 instance_type = "t2.micro"
 key_name = "jenkinsnvirginia"
 vpc_security_group_ids = [aws_security_group.sample_SG.id]
# subnet_id = "aws_subnet.pub_subnets.id"
 subnet_id      = aws_subnet.public_subnets.id
 tags = {
  Name = "Server-1"
  Env  = "Prod"
 }
}

resource "aws_ebs_volume" "data-vol" {
 availability_zone = "us-east-1a"
 size = 1
 tags = {
        Name = "data-volume"
 }
}

resource "aws_volume_attachment" "volume-attach" {
 device_name = "/dev/sdc"
 volume_id = "${aws_ebs_volume.data-vol.id}"
 instance_id = "${aws_instance.server-1.id}"
}
