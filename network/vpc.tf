resource "aws_vpc" "terraformCourse" {
  cidr_block = var.Vpccidr
  enable_dns_hostnames = true
  tags = {
    Name = "terraformCourse"
  }
}
