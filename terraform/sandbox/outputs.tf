output "bastion_ip_address" {
  value = "${aws_eip.bastion.public_ip}"
}
