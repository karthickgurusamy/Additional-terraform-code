provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "server1" {
  ami               = "ami-006dcf34c09e50022"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "jenkinsnvirginia"
  tags = {
        Name = "server-1"
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
 instance_id = "${aws_instance.server1.id}"
}


resource "aws_security_group" "sample_SG" {
  name        = "Sample_SG"
  description = "allow ssh and http traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
output "private-ip" {
  value = "${aws_instance.server1.private_ip}"
}

output "public-ip" {
  value = "${aws_instance.server1.public_ip}"
}
