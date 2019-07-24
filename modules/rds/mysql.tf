################RDS parameter group################
resource "aws_db_parameter_group" "mysql0o" {
	name   = "mysql0o-pg"
	family = "mysql5.7"
	
	parameter {
	name  = "character_set_server"
	value = "utf8"
	}
	
	parameter {
	name  = "character_set_client"
	value = "utf8"
	}
}
########RDS option group######################################
resource "aws_db_option_group" "mysql0o-opg" {
	name                     = "mysql0o-opg"
	option_group_description = "Terraform Option Group mysql0o-opg"
	engine_name              = "mysql"
	major_engine_version     = "5.7"
	
}
########################RDS subnet group##################
resource "aws_db_subnet_group" "mysql0o-subgp" {
	name       = "mysql0o-subgp"
	#subnet_ids = ["${element(var.subnet_ids,count.index)}"]
	subnet_ids = ["${var.subnet_ids}"]
	
	tags = {
	Name = "Mysql0o subnet group"
	}
}
######################RDS Instance######################
resource "aws_db_instance" "mysql0o-instance" {
	identifier			=	"${var.identifier}"
	vpc_security_group_ids = ["${var.security_group_names}"]
	allocated_storage    = "${var.storage}"
	storage_type         = "gp2"
	engine               = "${var.engine}"
	engine_version       = "${var.engine_version}"
	instance_class       = "${var.instance_class}"
	name                 = "${var.db_name}"
	username             = "${var.username}"
	password             = "${var.password}"
	skip_final_snapshot	=	"true"
	parameter_group_name = "${aws_db_parameter_group.mysql0o.id}"
	option_group_name = "${aws_db_option_group.mysql0o-opg.id}"
	db_subnet_group_name   =	"${var.subnet_gp}"
	
}

