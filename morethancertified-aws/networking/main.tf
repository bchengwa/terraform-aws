#morethancertified-aws/metworking/main.tf

#do not hardcode cidr_block as this is a module
resource "aws_vpc" "vpc_morethancert" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "aws_vpc-${random_integer.aws_random_vpc_number.id}"
    #when using Name within tag in aws, the Name is always in caps
  }
}

resource "random_integer" "aws_random_vpc_number" {
  min = 1
  max = 101
}

resource "aws_subnet" "public_subnet_mtc" {
  count = var.public_subnet_count
  vpc_id = aws_vpc.vpc_morethancert.id
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"][count.index]
  tags = {
    Name = "mtc_public_subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet_mtc" {
  count = var.private_subnet_count
  vpc_id = aws_vpc.vpc_morethancert.id
  cidr_block = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"][count.index]
  tags = {
    Name = "mtc_private_subnet ${count.index + 1}"
  }
}