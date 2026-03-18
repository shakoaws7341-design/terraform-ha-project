resource "aws_autoscaling_group" "asg" {

    desired_capacity = 2
    max_size = 3
    min_size = 2

    vpc_zone_identifier = [ 
        aws_subnet.private1,aws_subnet.private2
     ]

     target_group_arns = aws_lb_target_group.tg.arn
    launch_template {
      id = aws_launch_template.app.id
      version = "$latest"
    }
  
}