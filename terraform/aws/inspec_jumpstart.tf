//////////////////////////////////////////
/////////////Instance/////////////////////
resource "aws_instance" "inspec_jumpstart" {
  connection {
    user        = "${var.aws_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${var.project_ami}"
  instance_type               = "${var.server_instance_type}"
  key_name                    = "${var.aws_key_pair_name}"
  count                       = "${var.count}"
  subnet_id                   = "${aws_subnet.inspec_jumpstart_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.inspec_jumpstart.id}", "${aws_security_group.inspec_jumpstart.id}"]
  associate_public_ip_address = true

  tags {
    Name          = "inspec_jumpstart_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  # provisioner "remote-exec" {
  #     inline = [
  #         "sleep 30",
  #         "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
  #         "sudo systemctl restart sshd"
  #     ]
  # }
  provisioner "file" {
    content     = "${data.template_file.setup.rendered}"
    destination = "/tmp/setup.sh"
  }
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/setup.sh",
        "sudo /tmp/setup.sh",
    ]
}
}

////////////////////////////////
//////Templates/////////////////
data "template_file" "setup" {
 template = "${file("${path.module}/../templates/setup.sh")}"
}
