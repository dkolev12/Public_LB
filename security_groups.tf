# Security Groups Instances
resource "aws_security_group" "dynamicSG" {
  name        = "dynamic-sg"
  description = "allowed ingress ports"
  vpc_id      = aws_vpc.MyVPC1.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.ip_sg

    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "dev-security"
  }

}


#Security Group DB
resource "aws_security_group" "db" {
  name        = "allow_access_isnaces"
  description = "Allow traffic from EC2 instances"
  vpc_id      = aws_vpc.MyVPC1.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.dynamicSG.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}