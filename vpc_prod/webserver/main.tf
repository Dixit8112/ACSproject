terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

data "terraform_remote_state" "Prod_vpc" {
  backend = "s3"
  config = {
    bucket = "prodgroup12"
    key    = "vpc_prod/networkfile/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_key_pair" "key1" {
  key_name   = "key1"
  public_key = file("key1.pub")
}

resource "aws_instance" "bastionhost" {
  ami             = "ami-0427090fd1714168b"
  instance_type   = "t2.micro"
  subnet_id       = data.terraform_remote_state.Prod_vpc.outputs.public_subnet2_id
  key_name        = aws_key_pair.key1.key_name
  security_groups = [data.terraform_remote_state.Prod_vpc.outputs.bastionsg_id]

  user_data = templatefile("install_httpd1.sh",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )

  tags = {
    Name = "BastionHostVM"
  }
}


resource "aws_instance" "VM5" {
  ami             = "ami-0427090fd1714168b"
  instance_type   = "t2.micro"
  subnet_id       = data.terraform_remote_state.Prod_vpc.outputs.private_subnet1_id
  key_name        = aws_key_pair.key1.key_name
  security_groups = [data.terraform_remote_state.Prod_vpc.outputs.privatesg_id]


  user_data = templatefile("install_httpd2.sh",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )

  tags = {
    Name = "VM5 Prod Priavte"
  }
}

resource "aws_instance" "VM6" {
  ami             = "ami-0427090fd1714168b"
  instance_type   = "t2.micro"
  subnet_id       = data.terraform_remote_state.Prod_vpc.outputs.private_subnet2_id
  key_name        = aws_key_pair.key1.key_name
  security_groups = [data.terraform_remote_state.Prod_vpc.outputs.privatesg_id]

  user_data = templatefile("install_httpd2.sh",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )

  tags = {
    Name = "VM6 Prod Priavte"
  }
}

resource "aws_instance" "publicVM1" {
  ami             = "ami-0427090fd1714168b"
  instance_type   = "t2.micro"
  subnet_id       = data.terraform_remote_state.Prod_vpc.outputs.public_subnet1_id
  key_name        = aws_key_pair.key1.key_name
  security_groups = [data.terraform_remote_state.Prod_vpc.outputs.bastionsg_id]

  user_data = templatefile("install_httpd.sh",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  )

  tags = {
    Name = "Public VM1"
  }
}



resource "aws_instance" "publicVM3" {
  ami             = "ami-0427090fd1714168b"
  instance_type   = "t2.micro"
  subnet_id       = data.terraform_remote_state.Prod_vpc.outputs.public_subnet3_id
  key_name        = aws_key_pair.key1.key_name
  security_groups = [data.terraform_remote_state.Prod_vpc.outputs.bastionsg_id]

  tags = {
    Name = "Public VM3"
  }
}

resource "aws_instance" "publicVM4" {
  ami             = "ami-0427090fd1714168b"
  instance_type   = "t2.micro"
  subnet_id       = data.terraform_remote_state.Prod_vpc.outputs.public_subnet4_id
  key_name        = aws_key_pair.key1.key_name
  security_groups = [data.terraform_remote_state.Prod_vpc.outputs.bastionsg_id]

  tags = {
    Name = "Public VM4"
  }
}

# Create a load balancer
resource "aws_lb" "prod_lb" {
  name               = "prod-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.Prod_vpc.outputs.bastionsg_id]
  subnets = [
    data.terraform_remote_state.Prod_vpc.outputs.public_subnet1_id,
    data.terraform_remote_state.Prod_vpc.outputs.public_subnet2_id
  ]

  tags = {
    Name = "prod-lb"
  }
}

# Create target group
resource "aws_lb_target_group" "prod_tg" {
  name        = "prod-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.Prod_vpc.outputs.vpc_id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "prod-tg"
  }
}

# Attach instances to the target group
resource "aws_lb_target_group_attachment" "bastion" {
  target_group_arn = aws_lb_target_group.prod_tg.arn
  target_id        = aws_instance.bastionhost.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "public_vm1" {
  target_group_arn = aws_lb_target_group.prod_tg.arn
  target_id        = aws_instance.publicVM1.id
  port             = 80
}

# Create a listener
resource "aws_lb_listener" "non_prod_listener" {
  load_balancer_arn = aws_lb.prod_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_tg.arn
  }
}

