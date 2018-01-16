output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_a_subnet_id" {
  value = "${aws_subnet.public_a.id}"
}

output "public_c_subnet_id" {
  value = "${aws_subnet.public_c.id}"
}

output "private_a_subnet_id" {
  value = "${aws_subnet.private_a.id}"
}

output "private_c_subnet_id" {
  value = "${aws_subnet.private_c.id}"
}

output "sg_allow_vpc" {
  value = "${aws_security_group.allow_vpc.id}"
}
