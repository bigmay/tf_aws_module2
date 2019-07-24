output "web_sg_id" {
	value = "${aws_security_group.web-sg.id}"
}
output "app_sg_id" {
	value = "${aws_security_group.app-sg.id}"
}

output "alb_sg_id" {
	value = "${aws_security_group.alb-sg.id}"
}