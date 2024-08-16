provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "VPC" {
  cidr_block = var.cidr_name
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_1_public" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_subnet_1
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone1
  tags = {
    Name = "${var.vpc_name}-public-subnet-1"
  }
}

resource "aws_subnet" "subnet_2_public" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_subnet_2
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone2
  tags = {
    Name = "${var.vpc_name}-public-subnet-2"
  }
}

resource "aws_subnet" "subnet_3_public" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_subnet_3
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone3
  tags = {
    Name = "${var.vpc_name}-public-subnet-3"
  }
}

resource "aws_subnet" "subnet_4_public" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_subnet_4
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone4
  tags = {
    Name = "${var.vpc_name}-public-subnet-4"
  }
}

resource "aws_subnet" "subnet_1_private" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_subnet_1
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.vpc_name}-private-subnet-1"
  }
}

resource "aws_subnet" "subnet_2_private" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_subnet_2
  availability_zone = var.availability_zone2
  tags = {
    Name = "${var.vpc_name}-private-subnet-2"
  }
}

resource "aws_internet_gateway" "MyIGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

resource "aws_nat_gateway" "MyNAT" {
  allocation_id = aws_eip.NAT.id
  subnet_id     = aws_subnet.subnet_1_public.id
  tags = {
    Name = "${var.vpc_name}-NAT-gateway"
  }
}

resource "aws_eip" "NAT" {
  domain = "vpc"
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyIGW.id
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.MyNAT.id
  }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.subnet_1_public.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.subnet_2_public.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_subnet_3" {
  subnet_id      = aws_subnet.subnet_3_public.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_subnet_4" {
  subnet_id      = aws_subnet.subnet_4_public.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.subnet_1_private.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.subnet_2_private.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_security_group" "sg_bastion" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "${var.vpc_name}-bastion-security-group"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "sg_private" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "${var.vpc_name}-private-security-group"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
