resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key-pair"
}
resource "aws_instance" "bastion" {
  ami                         = "ami-09dd5f12915cfb387" # eu-west-1
  instance_type               = "t2.micro"
  key_name                    = "tf-key-pair"
  subnet_id                   = aws_subnet.PublicSubnet1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.security_group1.id]
  tags = {
    Name = "bastion"
  }
}
resource "aws_network_interface" "privatenet" {
  subnet_id       = aws_subnet.PrivateSubnet1.id
  security_groups = [aws_security_group.security_group2.id]
  tags = {
    Name = "private_network_interface"
  }
}
resource "aws_instance" "application" {
  ami           = "ami-09dd5f12915cfb387" # eu-west-1
  instance_type = "t2.micro"
  key_name      = "tf-key-pair"
  network_interface {
    network_interface_id = aws_network_interface.privatenet.id
    device_index         = 0
  }
  tags = {
    Name = "application"
  }
}
