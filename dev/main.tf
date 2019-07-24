########## This is tf for AWS
########## @Henrik Xia&May
########## 2019-07

############################################
provider "aws" {
	version = "~> 2.0"
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
	region = "${var.aws_region}"

}
module "dev_vpc" {
	source = "../modules/vpc"

	tenancy = "default"
	vpc_id = "${module.dev_vpc.vpc_id}"

}
module "dev_sg" {
	source = "../modules/sg"
	vpc_id = "${module.dev_vpc.vpc_id}"
	web_sg_id = ["${module.dev_sg.web_sg_id}"]
	app_sg_id = ["${module.dev_sg.app_sg_id}"]
	alb_sg_id = ["${module.dev_sg.alb_sg_id}"]  

}
module "dev_ec2" {
	source = "../modules/ec2"
	#ami_id = "ami-0ca4f92bcfe42233b"
	#instance_type = "t2.micro"
	#vpc_id = "${module.dev_vpc.vpc_id}"
	#subnet_id = ["${module.dev_vpc.public_subnets}"]
	#subnet_id = ["${module.dev_vpc.private_subnets}"]
	subnet_id = ["${module.dev_vpc.public_subnets}","${module.dev_vpc.private_subnets}"]
	web_sg_id = ["${module.dev_sg.web_sg_id}"]
	app_sg_id = ["${module.dev_sg.app_sg_id}"]
	

}
module "dev_alb" {
	source = "../modules/lb"
	vpc_id = "${module.dev_vpc.vpc_id}"
	alb_sg_id = ["${module.dev_sg.alb_sg_id}"]
	subnets =   ["${module.dev_vpc.public_subnets}"]
	target_id = ["${module.dev_ec2.instance-web-id}"]

}

module "dev_rds" {
	source = "../modules/rds"
	vpc_id = "${module.dev_vpc.vpc_id}"
	security_group_names = "${module.dev_sg.web_sg_id}"
	subnet_ids = ["${module.dev_vpc.public_subnets}"]
	subnet_gp  =   "${module.dev_rds.subnet_group}"


}


