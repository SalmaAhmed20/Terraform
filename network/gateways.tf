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