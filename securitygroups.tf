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