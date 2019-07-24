output "instance-web-id" {
	value = ["${aws_instance.web.*.id}"]
}