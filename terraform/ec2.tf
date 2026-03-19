data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public1.id

  vpc_security_group_ids = [aws_security_group.alb_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              echo "Hello from EC2" > /var/www/html/index.html
              EOF
}
