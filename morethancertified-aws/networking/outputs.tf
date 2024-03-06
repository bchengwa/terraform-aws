#morethanterraform/networking/output.tf
#how most resources will reference the vpc
output "vpc_id" {
  value = aws_vpc.vpc_morethancert.id
  #get the vpc id
}