# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Main VPC"
  }
}

# Subnets
resource "aws_subnet" "dev_public" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.0.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "dev_private" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.0.128/25"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Private Subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

# NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "NAT Elastic IP"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.dev_public.id

  tags = {
    Name = "NAT Gateway"
  }
}

# Route Tables
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

# Associate Route Tables with Subnets
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.dev_public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.dev_private.id
  route_table_id = aws_route_table.private_rt.id
}