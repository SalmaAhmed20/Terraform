resource "aws_vpc" "terraformCourse" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "terraformCourse"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraformCourse.id
  tags = {
    Name = "terrform-internet-gateway"
  }
}
# resource "aws_eip" "myelp" {
#   vpc = true
# }
resource "aws_subnet" "PublicSubnet1" {
    vpc_id = aws_vpc.terraformCourse.id
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = true
    enable_resource_name_dns_a_record_on_launch=true
    availability_zone = "eu-west-1a"
    tags = {
      Name = "terrform-public1-subnet"
    } 
}
resource "aws_subnet" "PublicSubnet2" {
  vpc_id = aws_vpc.terraformCourse.id
  map_public_ip_on_launch = true
  enable_resource_name_dns_a_record_on_launch=true
  cidr_block = "10.1.2.0/24"
  availability_zone = "eu-west-1b"
    tags = {
      Name = "terrform-public2-subnet"
    } 
}
# resource "aws_nat_gateway" "terraform-nat" {
#   allocation_id = aws_eip.myelp.id
#   subnet_id = aws_subnet.PublicSubnet1.id
#   tags={
#     name="terraformNat"
#   }  
# }
resource "aws_subnet" "PrivateSubnet1" {
  vpc_id = aws_vpc.terraformCourse.id
  cidr_block = "10.1.3.0/24"
  availability_zone = "eu-west-1a"
    tags = {
      Name = "terrform-private1-subnet"
    } 
}
resource "aws_subnet" "PrivateSubnet2" {
  vpc_id = aws_vpc.terraformCourse.id
  cidr_block = "10.1.4.0/24"
  availability_zone = "eu-west-1b"
    tags = {
      Name = "terrform-private2-subnet"
    } 
}