variable "web_sg_id" {
	description = "A list of security group IDs to associate with"
	type        = "list"
}
variable "app_sg_id" {
	description = "A list of security group IDs to associate with"
	type        = "list"
}
variable "alb_sg_id" {
	description = "A list of security group IDs to associate with"
	type        = "list"
}
variable "vpc_id" {
	description = "Define variables in main.tf"
}