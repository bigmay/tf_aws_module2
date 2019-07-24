######## Common VPC ####################
resource "aws_vpc" "main" {
	cidr_block       = "${var.vpc_cidr}"
	instance_tenancy = "${var.tenancy}"
	enable_dns_hostnames = "${var.enable_dns_hostnames}"
	enable_dns_support   = "${var.enable_dns_support}"
	tags = {
		Name = "AAmain-vpc"
	}
}
######## Common IGW ####################
resource "aws_internet_gateway" "main-gw" {
	vpc_id = "${aws_vpc.main.id}"
	
	tags = {
		Name = "main-gw"
	}
}
######## Common NAT ####################
resource "aws_eip" "main-nat-eip" {	
}
resource "aws_nat_gateway" "main-nat-gw" {
	allocation_id = "${aws_eip.main-nat-eip.id}"
	subnet_id     = "${element(aws_subnet.public.*.id, (var.single_nat_gateway ? 0 : count.index))}"
	
	tags = {
		Name = "main-nat-gw"
	}
}
####### Common public-rt ##################
resource "aws_route_table" "main-public-rt" {
	vpc_id = "${aws_vpc.main.id}"
	
	route {
		cidr_block = "${var.route_table_cidr}"
		gateway_id = "${aws_internet_gateway.main-gw.id}"
	}
	
	tags = {
		Name = "main-public-rt"
	}
}
####### Common public-route_table_association ##################
resource "aws_route_table_association" "public" {
	count = "${length(var.pubsubnet_cidr)}"
	
	subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
	route_table_id = "${aws_route_table.main-public-rt.id}"
}
####### Common pubsubnet ##################
resource "aws_subnet" "public" {

	count =  "${length(data.aws_availability_zones.azs.names)}"
	vpc_id     = "${var.vpc_id}"
	#vpc_id  = "${aws_vpc.main.id}"  
	cidr_block = "${element(var.pubsubnet_cidr, count.index)}"
	availability_zone  = "${element(var.azs, count.index)}"
	map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
	
	tags = {
		Name = "AAmain-subnet-${count.index + 1}"
  }
}
####### Common private-rt ##################
resource "aws_route_table" "main-private-rt" {
	vpc_id = "${aws_vpc.main.id}"
	
	route {
		cidr_block = "${var.route_table_cidr}"
		nat_gateway_id = "${aws_nat_gateway.main-nat-gw.id}"
	}
	
	tags = {
		Name = "main-private-rt"
	}
}
####### Common private-route_table_association ##################
resource "aws_route_table_association" "private" {
	count = "${length(var.prisubnet_cidr)}"
	
	subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
	route_table_id = "${aws_route_table.main-private-rt.id}"
}
######## Common private-subnet ###################
resource "aws_subnet" "private" {
	count =  "${length(data.aws_availability_zones.azs.names)}"
	vpc_id     = "${var.vpc_id}"
	#vpc_id  = "${aws_vpc.main.id}"  
	cidr_block = "${element(var.prisubnet_cidr, count.index)}"
	availability_zone  = "${element(var.azs, count.index)}"
	map_public_ip_on_launch = "${var.map_private_ip_on_launch}"
	
	tags = {
		Name = "AAmain-subnet-${count.index + 1}"
	}
}

################################################SG

