resource "aws_alb" "alb" {
    name = "devops-alb"
    internal = false 
    load_balancer_type = "application"

    security_groups = [ aws_security_group.alb_sg.id ]
    subnets = [ 
        aws_subnet.public1,
        aws_subnet.public2 ]
  
}

resource "aws_lb_target_group" "tg" {
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}