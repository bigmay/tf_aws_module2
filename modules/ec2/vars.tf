variable "ami_id" {
	description = "A list of AMI"
	default     = ["ami-08b835182371dee58","ami-0ca4f92bcfe42233b"]
}

variable "instance_count" {
	description = "count of instance"
	default     = "1"
}

variable "instance_type" {
	default = "t2.micro"
}

variable "subnet_id" {
	type = "list"
	#default = ["${aws_subnet.main.*.id}"]
}
#variable "private_subnets" {
#	type = "list"
#}
#variable "public_subnets" {
#	type = "list"
#}
variable "web_sg_id" {
	description = "A list of security group IDs to associate with"
	type        = "list"
}
variable "app_sg_id" {
	description = "A list of security group IDs to associate with"
	type        = "list"
}

#variable "instance_num" {}

#data "aws_availability_zones" "azs" {}

