resource "aws_launch_template" "app" {
  name_prefix   = "app-lt"
  image_id      = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.alb_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              echo "Hello from ASG" > /var/www/html/index.html
              EOF
  )
}
resource "aws_autoscaling_group" "asg" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg.arn]

  health_check_type = "EC2"
}