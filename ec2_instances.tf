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
  ami                         = var.AMI
  instance_type               = var.INSTANCE_TYPE
  key_name                    = "tf-key-pair"
  subnet_id                   = module.networks.PubsubnetID1
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.networks.sgID1]
  tags = {
    Name = "bastion"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip}"
  }
}
resource "aws_network_interface" "privatenet" {
  subnet_id       = module.networks.PrivsubnetID1
  security_groups = [module.networks.sgID2]
  tags = {
    Name = "private_network_interface"
  }
}
resource "aws_instance" "application" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name      = "tf-key-pair"
  network_interface {
    network_interface_id = aws_network_interface.privatenet.id
    device_index         = 0
  }
  tags = {
    Name = "application"
  }
}
