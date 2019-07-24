#output "alb_sg_id" {
#	value = "${aws_security_group.alb-sg.id}"
#}

output "alb1-tg-arn" {
	value = "${aws_lb_target_group.alb1-tg.arn}"
}