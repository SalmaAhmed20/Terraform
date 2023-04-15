output "PubsubnetID1" {
    value = aws_subnet.PublicSubnet1.id
}
output "PubsubnetID2" {
    value = aws_subnet.PublicSubnet2.id
}
output "PrivsubnetID1" {
    value = aws_subnet.PrivateSubnet1.id
}
output "PrivsubnetID2" {
    value = aws_subnet.PrivateSubnet2.id
}
output "sgID1" {
  value = aws_security_group.security_group1.id
}
output "sgID2" {
  value = aws_security_group.security_group2.id
}
output "RDSsg" {
  value = aws_security_group.rds-app-prod.id
}
output "natt" {
  value=aws_nat_gateway.terraform-nat
}