resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.terraformCourse.id
  tags = {
    Name = "rtb_public"
  }
}
resource "aws_route_table_association" "apub" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_route_table_association" "bpub" {
  subnet_id      = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.terraformCourse.id
  tags = {
    Name = "rtb_priv"
  }
}
resource "aws_route_table_association" "apriv" {
  subnet_id      = aws_subnet.PrivateSubnet1.id
  route_table_id = aws_route_table.rtb_private.id
}
resource "aws_route_table_association" "bpriv" {
  subnet_id      = aws_subnet.PrivateSubnet2.id
  route_table_id = aws_route_table.rtb_private.id
}
resource "aws_route" "r" {
  route_table_id = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}
# resource "aws_route" "rnat" {
#   route_table_id = aws_route_table.rtb_public.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.terraform-nat.id
# }
# resource "aws_route_table_association" "privr2" {
#   route_table_id = aws_route_table.rtb_private.id
#   nat_gateway_id  = aws_nat_gateway.terraform-nat.id
# }