/////AWS Security Group//////////
//////////////////////////////
resource "aws_security_group" "inspec_jumpstart" {
  name        = "inspec_jumpstart_${random_id.instance_id.hex}"
  description = "base rules for inspec_jumpstart workshop"
  vpc_id      = "${aws_vpc.inspec_jumpstart_vpc.id}"

  tags {
    Name          = "${var.X-Customer}-${var.X-Project}_${random_id.instance_id.hex}_${var.X-Application}_security_group"
    X-Dept        = "${var.X-Dept}"
    X-Customer    = "${var.X-Customer}"
    X-Project     = "${var.X-Project}"
    X-Application = "${var.X-Application}"
    X-Contact     = "${var.X-Contact}"
    X-TTL         = "${var.tag_ttl}"
  }
}

///////////////////////////////////
//////Default Security Groups//////
resource "aws_security_group_rule" "ingress_allow_22_tcp_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.inspec_jumpstart.id}"
}

resource "aws_security_group_rule" "ingress_allow_80_tcp_all" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.inspec_jumpstart.id}"
}

resource "aws_security_group_rule" "ingress_allow_8000_tcp_all" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.inspec_jumpstart.id}"
}


resource "aws_security_group_rule" "ingress_allow_8080_tcp_all" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.inspec_jumpstart.id}"
}

resource "aws_security_group_rule" "ingress_allow_443_tcp_all" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.inspec_jumpstart.id}"
}

# Egress: ALL
resource "aws_security_group_rule" "egress_allow_0-65535_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.inspec_jumpstart.id}"
}
