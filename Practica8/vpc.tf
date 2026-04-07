resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public_subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "private_subnet-${local.sufix}"
  }
  depends_on = [aws_subnet.public_subnet]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pubic crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}


resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance"
  description = "Allow SSH inbound traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    description = "SSH Over Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Instance-${local.sufix}"
  }
}

module "mybucket" {
  source      = "./modulos/s3"
  bucket_name = "bucket-${local.sufix}"
}

output "s3_arn" {
  value = module.mybucket.s3_bucket_arn
}

# module "terraform_state_backend" {
#   source = "cloudposse/tfstate-backend/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   version     = "1.9.0"
#   namespace   = "ejemplo"
#   stage       = "dev"
#   name        = "terraform"
#   environment = "us-east1"
#   attributes  = ["state"]

#   terraform_backend_config_file_path = "."
#   terraform_backend_config_file_name = "backend.tf"
#   force_destroy                      = true
# }
