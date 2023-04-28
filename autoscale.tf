resource "aws_launch_template" "my-lauch-template" {
  name            = "my-lauch-template"
  image_id        = "ami-02396cdd13e9a1257"
  instance_type   = "t2.micro"
  key_name        = "my-key"
  vpc_security_group_ids = ["${aws_security_group.my-sg.id}"]
  user_data         = file("install_apache.sh")


  resource "aws_autoscaling_group" "my-autoscale" {
  name                      = "my-autoscale"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  launch_template           = aws_launch_template.my-lauch-template.name
  vpc_zone_identifier       = [aws_subnet.my-publicweb-subnet1.id, aws_subnet.my-publicweb-subnet2.id]
  target_group_arn          = aws_lb_target_group.my-alb-target.arn
  

  tag {
    key                 = "my-scale"
    value               = "my-scaling"

  }
}
}