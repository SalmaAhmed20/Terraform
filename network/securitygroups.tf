resource "aws_security_group" "security_group1" {
  vpc_id = aws_vpc.terraformCourse.id
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "terraform-sg1"
  }
}

resource "aws_security_group" "security_group2" {
  vpc_id = aws_vpc.terraformCourse.id
  ingress{
    cidr_blocks = [
      aws_vpc.terraformCourse.cidr_block
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "terraform-sg2"
  }
}

resource "aws_security_group_rule" "sg2rule" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.terraformCourse.cidr_block]
  security_group_id = aws_security_group.security_group2.id
}

resource "aws_security_group" "rds-app-prod" {
  vpc_id = aws_vpc.terraformCourse.id
  name = "rds-app-prod"
  description = "Allow inbound mysql traffic"
  tags = {
    Name = "rds-app-prod"
  }
}
resource "aws_security_group_rule" "allow-mysql" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_group_id = aws_security_group.rds-app-prod.id
    cidr_blocks = [ aws_subnet.PrivateSubnet1.cidr_block ]
}
resource "aws_security_group_rule" "allow-outgoing" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.rds-app-prod.id
    cidr_blocks = ["0.0.0.0/0"]
}