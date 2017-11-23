provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "${var.region}"
}

#Provisioning the machine
resource "aws_instance" "web" {
    count = "1"
    ami = "${var.amis}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    availability_zone = "${var.region}${element(split(",",var.zones),count.index)}"
    vpc_security_group_ids = ["${aws_security_group.demo_sg.id}"]
    subnet_id = "${element(split(",",var.subnet_id),count.index)}"
    user_data = "${file("web-config.sh")}"
	tags {
    Name = "web-server${count.index + 1}"
    Owner = "web-cluster"
  }
}

 resource "aws_security_group" "demo_sg" {
  vpc_id = "${var.vpc_id}"
  name = "${var.security_group_name}"
  description = "demo security group"
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["10.128.0.0/10"]
  }
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}