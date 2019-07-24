resource "aws_security_group" "web-sg" {
	vpc_id = "${var.vpc_id}"
	name = "main-web-sg"
	ingress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
		description = "main-web-sg"
	}
	  
	# Outbound internet access
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	tags = {
		Name = "main-web-sg"
	}
}

resource "aws_security_group" "app-sg" {
	vpc_id = "${var.vpc_id}"
	name = "main-app-sg"
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "main-app-sg"
	}
	  
	# Outbound internet access
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	tags = {
		Name = "main-app-sg"
	}
}

resource "aws_security_group" "alb-sg" {
	vpc_id = "${var.vpc_id}"
	name = "alb-sg"
	description = "Allow TLS inbound traffic"
	
	ingress {
	
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	tags = {
		Name = "alb-sg"
	}
}