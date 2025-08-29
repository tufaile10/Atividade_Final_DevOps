
# Latest Amazon Linux 2 AMI
data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon (amzn2)
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# User data to install a simple web server
locals {
  user_data = <<-EOT
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    echo "<h1>Aplicativo de Entrega - EC2 atrás do ALB</h1><p>OK</p>" > /var/www/html/index.html
  EOT
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amzn2.id
  instance_type          = var.ec2_instance_type
  subnet_id              = values(aws_subnet.public)[0].id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  user_data              = local.user_data

  key_name = var.create_key_pair_name # optional

  tags = {
    Name = "${var.project_name}-web"
  }
}
