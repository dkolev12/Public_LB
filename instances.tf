# EC2 Instances with NGINX running
resource "aws_instance" "ec2_instance1" {
  ami                    = data.aws_ami.app_ami.id
  instance_type          = "t2.micro"
  key_name               = "key-pair"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.dynamicSG.id]
  user_data              = <<-EOF
  #!/bin/bash
  # User data for new EC2 instances
  # install httpd (Linux 2 version)
  yum update -y
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  echo "<h1>Hello World! This is $(hostname -f)</h1>" > /var/www/html/index.html
  EOF

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./key-pair.pem")
    host        = self.public_ip

    tags = {
      Name = "Isnatnce1"
    }

  }

}

resource "aws_instance" "ec2_instance2" {
  ami                    = data.aws_ami.app_ami.id
  instance_type          = "t2.micro"
  key_name               = "key-pair"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.dynamicSG.id]
  user_data              = <<-EOF
  #!/bin/bash
  # User data for new EC2 instances
  # install httpd (Linux 2 version)
  yum update -y
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  echo "<h1>Hello World! This is $(hostname -f)</h1>" > /var/www/html/index.html
  EOF


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./key-pair.pem")
    host        = self.public_ip

    tags = {
      Name = "Instance2"
    }

  }

}
