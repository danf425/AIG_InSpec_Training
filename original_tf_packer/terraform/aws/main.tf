provider "aws" {
  region                  = "${var.aws_region}"
  profile                 = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
}

resource "random_id" "instance_id" {
  byte_length = 4
}

////////////////////////////////
////////////VPC////////////////
resource "aws_vpc" "inspec_jumpstart_vpc" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name          = "${var.X-Name}-vpc"
    X-Dept        = "${var.X-Dept}"
    X-Customer    = "${var.X-Customer}"
    X-Project     = "${var.X-Project}"
    X-Contact     = "${var.X-Contact}"
    X-Application = "${var.X-Application}"
    X-TTL         = "${var.tag_ttl}"
  }
}

////////////////////////////////
////////////Gateway//////////////
resource "aws_internet_gateway" "inspec_jumpstart_gateway" {
  vpc_id = "${aws_vpc.inspec_jumpstart_vpc.id}"
  tags {
    Name = "${var.X-Name}_inspec_jumpstart_gateway-${var.X-Application}"
  }
}

////////////////////////////////
////////////Access//////////////
resource "aws_route" "inspec_jumpstart_internet_access" {
  route_table_id         = "${aws_vpc.inspec_jumpstart_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.inspec_jumpstart_gateway.id}"
}

////////////////////////////////
////////////Subnet//////////////
resource "aws_subnet" "inspec_jumpstart_subnet" {
  vpc_id                  = "${aws_vpc.inspec_jumpstart_vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.X-Name}_inspec_jumpstart_subnet-${var.X-Application}"
  }
}


////////////////////////////////
////////Instance Data///////////
/////Specific Chef CentOS/////
data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["chef-highperf-centos7-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["446539779517"]
}

