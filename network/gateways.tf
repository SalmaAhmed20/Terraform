resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraformCourse.id
  tags = {
    Name = "terrform-internet-gateway"
  }
}
resource "aws_eip" "myelp" {
  vpc = true
}

resource "aws_nat_gateway" "terraform-nat" {
  allocation_id = aws_eip.myelp.id
  subnet_id = aws_subnet.PublicSubnet1.id
  tags={
    name="terraformNat"
  }  
}
resource "aws_eip" "myelp2" {
  vpc = true
}
resource "aws_nat_gateway" "terraform-nat2" {
  allocation_id = aws_eip.myelp2.id
  subnet_id = aws_subnet.PublicSubnet2.id
  tags={
    name="terraformNat2"
  }  
}