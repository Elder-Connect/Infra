module "net" {
  source = "../network"
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_pair_name
  public_key = file("elderly.pem.pub")
}

# Instância pública
resource "aws_instance" "frontend-proxy" {
  ami               = var.ami
  availability_zone = var.a_zone
  instance_type     = var.inst_type
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "standard"
  }
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = module.net.subnet_public_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.net.sg_id]
  tags = {
    Name = "frontend-proxy"
  }
}

resource "aws_eip" "frontend_proxy_eip" {
  instance = aws_instance.frontend-proxy.id

  tags = {
    Name = "frontend-proxy-eip"
  }
}

# Primeira instância privada
resource "aws_instance" "backend" {
  ami               = var.ami
  availability_zone = var.a_zone
  instance_type     = var.inst_type
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "standard"
  }
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = module.net.subnet_private_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [module.net.sg_id]
  tags = {
    Name = "backend"
  }
}

# Segunda instância privada
resource "aws_instance" "database" {
  ami               = var.ami
  availability_zone = var.a_zone
  instance_type     = var.inst_type
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "standard"
  }
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = module.net.subnet_private_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [module.net.sg_id]
  tags = {
    Name = "database"
  }
}
