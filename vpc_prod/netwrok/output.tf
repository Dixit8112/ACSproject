output "vpc_id" {
  value = aws_vpc.VPC.id
}

output "public_subnet1_id" {
  value = aws_subnet.subnet_1_public.id
}

output "public_subnet2_id" {
  value = aws_subnet.subnet_2_public.id
}

output "public_subnet3_id" {
  value = aws_subnet.subnet_3_public.id
}

output "public_subnet4_id" {
  value = aws_subnet.subnet_4_public.id
}

output "private_subnet1_id" {
  value = aws_subnet.subnet_1_private.id
}

output "private_subnet2_id" {
  value = aws_subnet.subnet_2_private.id
}

output "bastionsg_id" {
  value = aws_security_group.sg_bastion.id
}

output "privatesg_id" {
  value = aws_security_group.sg_private.id
}

output "public_routetable_id" {
  value = aws_route_table.public_route.id
}

output "private_routetable_id" {
  value = aws_route_table.private_route.id
}

output "internetgateway_id" {
  value = aws_internet_gateway.MyIGW.id
}

output "natgateway_id" {
  value = aws_nat_gateway.MyNAT.id
}

output "vpc_cidr" {
  value = aws_vpc.VPC.cidr_block
}
