resource "aws_subnet" "PublicSubnet1" {
    vpc_id = aws_vpc.terraformCourse.id
    cidr_block = var.publicsubnet1cider
    map_public_ip_on_launch = true
    enable_resource_name_dns_a_record_on_launch=true
    availability_zone = var.AvaZone_1
    tags = {
      Name = "terrform-public1-subnet"
    } 
}
resource "aws_subnet" "PublicSubnet2" {
  vpc_id = aws_vpc.terraformCourse.id
  map_public_ip_on_launch = true
  enable_resource_name_dns_a_record_on_launch=true
  cidr_block = var.publicsubnet2cider
  availability_zone = var.AvaZone_2
    tags = {
      Name = "terrform-public2-subnet"
    } 
}
resource "aws_subnet" "PrivateSubnet1" {
  vpc_id = aws_vpc.terraformCourse.id
  cidr_block = var.privsubnet1cider
  availability_zone = var.AvaZone_1
    tags = {
      Name = "terrform-private1-subnet"
    } 
}
resource "aws_subnet" "PrivateSubnet2" {
  vpc_id = aws_vpc.terraformCourse.id
  cidr_block = var.privsubnet2cider
  availability_zone = var.AvaZone_2
    tags = {
      Name = "terrform-private2-subnet"
    } 
}