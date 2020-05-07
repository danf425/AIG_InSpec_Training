output "inspec_jumpstart_public_ip" {
  value = "${aws_instance.inspec_jumpstart.*.public_ip}"
}
