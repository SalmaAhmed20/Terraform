resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [module.networks.PrivsubnetID1, module.networks.PrivsubnetID2]
  tags = {
    Name = "RDSSubnets"
  }
}
resource "aws_db_instance" "terraformRDS" {
  identifier             = "terraformrds"
  instance_class         = "db.t3.micro"
  engine                 = "mysql"
  engine_version         = "5.7"
  username               = "edu"
  allocated_storage      = 20
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [module.networks.RDSsg]
  skip_final_snapshot    = true
}
