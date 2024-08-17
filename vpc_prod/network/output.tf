output "vpc_id" {
  value = module.Prod_vpc.vpc_id
}

output "public_subnet1_id" {
  value = module.Prod_vpc.public_subnet1_id
}

output "public_subnet2_id" {
  value = module.Prod_vpc.public_subnet2_id
}

output "public_subnet3_id" {
  value = module.Prod_vpc.public_subnet3_id
}

output "public_subnet4_id" {
  value = module.Prod_vpc.public_subnet4_id
}

output "private_subnet1_id" {
  value = module.Prod_vpc.private_subnet1_id
}

output "private_subnet2_id" {
  value = module.Prod_vpc.private_subnet2_id
}

output "bastionsg_id" {
  value = module.Prod_vpc.bastionsg_id
}

output "privatesg_id" {
  value = module.Prod_vpc.privatesg_id
}

output "public_routetable_id" {
  value = module.Prod_vpc.public_routetable_id
}

output "private_routetable_id" {
  value = module.Prod_vpc.private_routetable_id
}

output "internetgateway_id" {
  value = module.Prod_vpc.internetgateway_id
}

output "natgateway_id" {
  value = module.Prod_vpc.natgateway_id
}

output "vpc_cidr" {
  value = module.Prod_vpc.vpc_cidr
}
