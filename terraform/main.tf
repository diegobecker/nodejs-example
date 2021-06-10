terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.26.0"
        }
    }
    required_version = "~> 0.14.5"
}

provider "aws" {
    region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_security_group" "sg" {
  name   = "sg"
  vpc_id = aws_vpc.vpc.id

  # SSH access from the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "dev" {
  ami                         = "ami-023216154d570ea0e"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_public.id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Dev"
  }
}

output "public_ip" {
  value = aws_instance.dev.public_ip
}

output "public_dns" {
  value = aws_instance.dev.public_dns
}


resource "aws_route53_zone" "zone" {
  name              = "myzonedb.app.br"
#   delegation_set_id = "${var.delegation_set_id}"
}

resource "aws_route53_record" "ns" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "myzonedb.app.br"
  type    = "NS"
  ttl     = "60"

  records = [
    aws_route53_zone.zone.name_servers.0,
    aws_route53_zone.zone.name_servers.1,
    aws_route53_zone.zone.name_servers.2,
    aws_route53_zone.zone.name_servers.3,
  ]
}