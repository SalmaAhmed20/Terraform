resource "tls_private_key" "rsa-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair"
  public_key = tls_private_key.rsa-key.public_key_openssh
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa-key.private_key_pem
  filename = "tf-key-pair.pem"
}
resource "aws_instance" "bastion" {
  ami                         = var.AMI
  instance_type               = var.INSTANCE_TYPE
  key_name                    = "tf-key-pair"
  subnet_id                   = module.networks.PubsubnetID1
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.networks.sgID1]
  user_data                   = <<-EOF
              #!/bin/bash
                echo '${tls_private_key.rsa-key.private_key_pem}' > /home/ubuntu/tf-key-pair.pem
                chmod 400 tf-key-pair.pem
             EOF            

  tags = {
    Name = "bastion"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
  }
}
resource "aws_network_interface" "privatenet" {
  subnet_id       = module.networks.PrivsubnetID1
  security_groups = [module.networks.sgID2]
  tags = {
    Name = "private_network_interface"
  }
}
resource "aws_network_interface" "privatenet2" {
  subnet_id       = module.networks.PrivsubnetID2
  security_groups = [module.networks.sgID2]
  tags = {
    Name = "private_network_interface2"
  }
}
resource "aws_instance" "application" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name      = "tf-key-pair"
  depends_on    = [module.networks.natt]
  user_data                   = <<-EOF
              #!/bin/bash
                echo '${tls_private_key.rsa-key.private_key_pem}' > /home/ubuntu/tf-key-pair.pem
                chmod 400 tf-key-pair.pem
                apt install mysql-client -y
             EOF            
  network_interface {
    network_interface_id = aws_network_interface.privatenet.id
    device_index         = 0
  }
  tags = {
    Name = "application"
  }
}
resource "aws_instance" "bastion2" {
  ami                         = var.AMI
  instance_type               = var.INSTANCE_TYPE
  key_name                    = "tf-key-pair"
  subnet_id                   = module.networks.PubsubnetID2
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.networks.sgID1]
  user_data                   = <<-EOF
              #!/bin/bash
                echo '${tls_private_key.rsa-key.private_key_pem}' > /home/ubuntu/tf-key-pair.pem
                chmod 400 tf-key-pair.pem
             EOF            

  tags = {
    Name = "bastion2"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
  }
}
resource "aws_instance" "application2" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name      = "tf-key-pair"
  depends_on    = [module.networks.natt]
  user_data                   = <<-EOF
              #!/bin/bash
                echo '${tls_private_key.rsa-key.private_key_pem}' > /home/ubuntu/tf-key-pair.pem
                chmod 400 tf-key-pair.pem
                apt install mysql-client -y
             EOF            
  network_interface {
    network_interface_id = aws_network_interface.privatenet2.id
    device_index         = 0
  }
  tags = {
    Name = "application"
  }
}