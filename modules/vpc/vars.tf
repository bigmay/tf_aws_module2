######## VPC CIDR #####################
variable "vpc_id" {
}
variable "vpc_cidr" {
	default = "162.31.0.0/16"
}
variable "tenancy" {
	default = "dedicated"
}
variable "enable_dns_hostnames" {
	description = "should be true if you want to use private DNS within the VPC"
	default     = true
}
variable "enable_dns_support" {
	description = "should be true if you want to use private DNS within the VPC"
	default     = true
}
######### VPC public-rt ###################
variable "name" {
	description = "Name to be used on all the resources as identifier"
	default     = "main"
}
variable "route_table_cidr" {
	description = "The CIDR block for the route_table_cidr"
	default     = "0.0.0.0/0"
}
######### VPC pubsubnet ###################
variable "pubsubnet_cidr" {
	type = "list"
	default =  ["162.31.1.0/24","162.31.2.0/24","162.31.3.0/24"]
}
variable "azs" {
	description = "A list of Availability zones in the region"
	default     = ["cn-north-1a","cn-north-1b"]
}
variable "map_public_ip_on_launch" {
	description = "should be false if you do not want to auto-assign public IP on launch"
	default     = true
}
######### VPC prisubnet ###################
variable "prisubnet_cidr" {
	type = "list"
	default =  ["162.31.11.0/24","162.31.12.0/24","162.31.13.0/24"]
}
variable "map_private_ip_on_launch" {
	description = "should be false if you do not want to auto-assign public IP on launch"
	default     = true
}
######## VPC NAT #####################
variable "single_nat_gateway" {
	description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
	default     = false
}
variable "enable_nat_gateway" {
	description = "should be true if you want to provision NAT Gateways for each of your private networks"
	default     = false
}
######### Data source AZ ################
data "aws_availability_zones" "azs" {}
