

# VPC and Subnet
resource "aws_vpc" "MyVPC1" {
  cidr_block           = var.custom_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.MyVPC1.id
  cidr_block              = var.custom_subet1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-public"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.MyVPC1.id
  cidr_block              = var.custom_subet2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-public"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.MyVPC1.id

  tags = {
    Name = "dev-igw"
  }
}

# Routing
resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.MyVPC1.id

  tags = {
    Name = "dev-public-route"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.route1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw1.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route1.id
}



