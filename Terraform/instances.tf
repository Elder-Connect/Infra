# SSH Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "elderly"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = "Elderly"
  }
}

# EC2 Instances
resource "aws_instance" "frontend" {
  ami             = "ami-0e86e20dae9224db8"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.dev_public.id
  security_groups = [aws_security_group.api.id]
  key_name        = aws_key_pair.deployer.key_name

  associate_public_ip_address = true

  tags = {
    Name = "Frontend EC2"
  }
}

resource "aws_instance" "backend" {
  ami             = "ami-0e86e20dae9224db8"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.dev_private.id
  security_groups = [aws_security_group.api.id]
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    Name = "Backend EC2"
  }
}

resource "aws_instance" "database" {
  ami             = "ami-0e86e20dae9224db8"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.dev_private.id
  security_groups = [aws_security_group.api.id]
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    Name = "Database EC2"
  }
}

# Elastic IP for Frontend
resource "aws_eip" "frontend_eip" {
  instance = aws_instance.frontend.id
  vpc      = true

  tags = {
    Name = "FrontEnd Elastic IP"
  }
}