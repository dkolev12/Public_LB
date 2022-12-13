resource "aws_db_parameter_group" "default" {
  name   = "mariadb"
  family = "mariadb10.6"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "mainsubntes"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "mariadb" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mariadb"
  engine_version         = "10.6.10"
  instance_class         = "db.t2.micro"
  db_name                = "myDB1"
  username               = var.db_user
  password               = var.db_password
  parameter_group_name   = "mariadb"
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.db.id]
  availability_zone      = aws_subnet.subnet1.availability_zone
  skip_final_snapshot    = true
}

