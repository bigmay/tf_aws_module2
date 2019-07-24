######### ec2 instance ##############

resource "aws_key_pair" "deployer" {
	key_name   = "deployer-key"
	public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
resource "aws_instance" "web" {
	#count = "${length(data.aws_availability_zones.azs.names)}"
	count = "${var.instance_count}"

	ami = "${element(var.ami_id,0)}"
	#ami = "ami-08b835182371dee58"
	key_name		=	"deployer-key"
	instance_type = "${var.instance_type}"
	subnet_id     = "${element(var.subnet_id, 0)}"
	security_groups = ["${element(var.web_sg_id, 0)}"]
	
	tags = {
	Name = "Instance_new_world-${count.index + 1}"
	
	}
}

resource "aws_instance" "web1" {
	#count = "${length(data.aws_availability_zones.azs.names)}"
	count = "${var.instance_count}"
	
	ami = "${element(var.ami_id,0)}"
	#ami = "ami-08b835182371dee58"
	key_name		=	"deployer-key"
	instance_type = "${var.instance_type}"
	subnet_id     = "${element(var.subnet_id, 2)}"
	security_groups = ["${element(var.web_sg_id, 0)}"]
	
	tags = {
	Name = "Instance_new_world-${count.index + 1}"
	
	}
}