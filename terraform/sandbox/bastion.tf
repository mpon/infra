resource "aws_instance" "bastion" {
  ami           = "ami-33c25b55"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  subnet_id     = "${module.base_network.public_a_subnet_id}"

  security_groups = [
    "${module.base_network.sg_allow_vpc}",
    "${aws_security_group.bastion.id}",
  ]

  tags {
    Name = "bastion"
  }
}

resource "aws_eip" "bastion" {
  vpc      = true
  instance = "${aws_instance.bastion.id}"

  tags {
    Name = "bastion"
  }
}

resource "aws_security_group" "bastion" {
  name   = "bastion"
  vpc_id = "${module.base_network.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.bastion_allow_cidr_blocks}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
