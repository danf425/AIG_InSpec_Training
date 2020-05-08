////////////////////////////////
//// AWS Connection/////////////
variable "aws_profile" {}
variable "aws_region" {
  default = "us-west-2"
}
/////////////////////////////////
//////////Route53 Settings///////
//variable "route53_zone_id" {}
//variable "route53_zone_name" {}
////////////////////////////////
//////////AWS Key Info/////////
variable "aws_key_pair_file" {}
variable "aws_key_pair_name" {}
/////////////////////////////////
////////////////////////////////
////AWS Server Settings///////////
variable "project_ami" {
  default = "ami-08779c11b418f768f"
}

variable "aws_image_user" {
  default = "centos"
}
variable "server_instance_type" {
  default = "t2.micro"
}
variable "count" { 
  default = "1" 
}

////////////////////////////
// Tags////////////////////
variable "X-Customer" {}

variable "X-Project" {}

variable "X-Name" {}

variable "X-Dept" {}

variable "X-Contact" {}

variable "X-Application" {}

variable "tag_ttl" {
  default = 4
}


////////////////////////////////////
/////Habitat Specific Variables/////
variable "channel" { default = "stable" }
variable "dev_channel" { default = "unstable" }
variable "prod_channel" { default = "stable" }
variable "origin" { default = "danf"}
