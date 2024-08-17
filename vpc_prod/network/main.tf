module "Prod_vpc" {
  source = "../../network_module"

  cidr_name          = "10.1.0.0/16"
  vpc_name           = "Prod-vpc"
  public_subnet_1    = "10.1.1.0/24"
  public_subnet_2    = "10.1.2.0/24"
  public_subnet_3    = "10.1.3.0/24"
  public_subnet_4    = "10.1.4.0/24"
  private_subnet_1   = "10.1.5.0/24"
  private_subnet_2   = "10.1.6.0/24"
  availability_zone1 = "us-east-1a"
  availability_zone2 = "us-east-1b"
  availability_zone3 = "us-east-1c"
  availability_zone4 = "us-east-1d"
}
