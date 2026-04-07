virginia_cidr = "10.10.0.0/16"
# public_subnet = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "Dev"
  "Owner"       = "Ronaldo Jaramillo"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC Versión" = "1.14.8"
  "project"     = "cerberus"
  "region"      = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-01b14b7ad41e17ba4"
  "instance_type" = "t3.micro"
}

enable_monitoring = false


ingress_port_list = [22, 80, 443]
