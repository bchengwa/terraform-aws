#morethancertified-aws/main.tf

module "networking" {
  source = "./networking"
  vpc_cidr = "10.123.0.0/16"

  #Hardcoded cidrs. Public cidrs are even, priviate cidrs are odd
  #public_cidrs = ["10.123.2.0/24", "10.123.4.0/24"]
  #private_cidrs = ["10.123.1.0/24", "10.123.3.0/24", "10.123.5.0/24"]

  #dynamic cidrs
  private_subnet_count = 3
  public_subnet_count = 2
  public_cidrs = [for i in range(2, 6, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
  private_cidrs = [for i in range(1, 6, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
}