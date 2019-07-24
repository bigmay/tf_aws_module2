#############################Application load_balancer#############################
resource "aws_lb" "alb-1" {
	name               = "alb-1"
	internal           = false
	load_balancer_type = "application"
	#security_groups    = ["${aws_security_group.alb_sg.id}"]
	security_groups    = ["${var.alb_sg_id}"]
	subnets            = ["${var.subnets}"]
	
	enable_deletion_protection = false
	
	#access_logs {
	#  bucket  = "${aws_s3_bucket.lb_logs.bucket}"
	#  prefix  = "alb1-lb"
	#  enabled = true
	#}
	
	tags = {
	Environment = "alb-1"
	}
}
#################################Target Group####################################
resource "aws_lb_target_group" "alb1-tg" {
	name     = "alb1-tg"
	port     = 80
	protocol = "HTTP"
	vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_target_group_attachment" "alb1" {
	target_group_arn = "${aws_lb_target_group.alb1-tg.arn}"
	target_id        = "${element(var.target_id, 0)}"
	port             = 80
}
####################ALB Listener########################
#resource "aws_lb_listener" "alb-1" {
#	load_balancer_arn = "${aws_lb.alb-1.arn}"
#	port              = "80"
#	protocol          = "HTTP"
#	
#	default_action {
#	type = "redirect"
#	
#	redirect {
#		port        = "443"
#		protocol    = "HTTPS"
#		status_code = "HTTP_301"
#	}
#	}
#}
#resource "aws_lb_listener" "alb-1" {
#	load_balancer_arn = "${aws_lb.alb-1.arn}"
#	port              = "80"
#	protocol          = "HTTP"
#	
#	default_action {
#	type = "fixed-response"
#	
#	fixed_response {
#		content_type = "text/plain"
#		message_body = "Fixed response content"
#		status_code  = "200"
#	}
#	}
#}

resource "aws_lb_listener" "alb-1" {
	load_balancer_arn = "${aws_lb.alb-1.arn}"
	port              = "80"
	protocol          = "HTTP"
	
	default_action {
	type             = "forward"
	target_group_arn = "${aws_lb_target_group.alb1-tg.arn}"
	}
}
