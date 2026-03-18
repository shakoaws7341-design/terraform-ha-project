resource "aws_launch_template" "app" {
    name_prefix = "devops-template"
    image_id = "ami-0f58b397bc5c1f2e8"
    instance_type = "t2.micro"
    key_name = var.key_name
    user_data = filebase64("../app/install.sh")

    network_interfaces {
      associate_public_ip_address = false 
      security_groups = [ aws_security_group.ec2_sg.id ]
    }
  
}