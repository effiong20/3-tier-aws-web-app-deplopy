resource "aws_launch_template" "my-lauch-template" {
  name            = "my-lauch-template"
  image_id        = "ami-02396cdd13e9a1257"
  instance_type   = "t2.micro"
  key_name        = "my-key"
  vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]
  user_data        = filebase64("install_apache.sh") 
 
}
  resource "aws_autoscaling_group" "my-autoscale" {
  name                      = "my-autoscale"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 200
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.my-publicweb-subnet1.id, aws_subnet.my-publicweb-subnet2.id]
  load_balancers            = [aws_elb.my-alb.name]
 // target_group_arns         = aws_lb_target_group.my-alb-target.arn

 launch_template {
    id      = aws_launch_template.my-lauch-template.id
    version = "$Latest"
  } 

tag {
    key                 = "name"
    value               = "my-autoscale"
    propagate_at_launch = true
  }

}


