variable "identifier" {
	default     = "mydb-rds"
	description = "Identifier for your DB"
}

variable "storage" {
	default     = "10"
	description = "Storage size in GB"
}

variable "engine" {
	default     = "mysql"
	description = "Engine type, example values mysql, postgres"
}

variable "engine_version" {
	description = "Engine version"
	default = "5.7"
}

variable "instance_class" {
	default     = "db.t2.micro"
	description = "Instance class"
}

variable "db_name" {
	default     = "mydb"
	description = "db name"
}

variable "username" {
	default     = "may"
	description = "User name"
}

variable "password" {
	description = "password, provide through your ENV variables"
	default     = "1qaz!QAZ"
}
variable "subnet_ids" {
	type = "list"
}

variable "vpc_id" {
	description = "Define variables in main.tf"
}
variable "security_group_names" {
	description = "Define variables in main.tf"
}
variable "subnet_gp" {
	description = "Define variables in main.tf"
}