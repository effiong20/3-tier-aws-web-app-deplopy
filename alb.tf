resource "aws_lb_target_group" "my-alb-target" {
  name             = "my-alb-target"
  port             = 80
  protocol         = "HTTP"
 // target_type      = "instance"
  target_type      = "alb"
  vpc_id           = aws_vpc.my-vpc.id

 health_check {
  interval  = 10
  path      = "/"
  protocol  = "HTTP"
  timeout   = 3
  healthy_threshold = 3
  unhealthy_threshold = 2
}
}
resource "aws_lb" "my-alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.my-sg.id}"]
  subnets            = [aws_subnet.my-publicweb-subnet1.id ,aws_subnet.my-publicweb-subnet2.id]
  enable_deletion_protection = false
 
 tags = {
    Environment = "my-alb-sample"
  }
}

resource "aws_lb_listener" "my-alb-listener" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = "80"
  protocol           = "HTTP"
  default_action {
    type             = "forward"
   target_group_arn = aws_lb_target_group.my-alb-target.arn
  }
}

resource "aws_lb_target_group_attachment" "att-to-target" {
  target_group_arn = aws_lb_target_group.my-alb-target.arn
  target_id        = aws_autoscaling_group.my-autoscale.id
  #target_id        = aws_instance.app-server[count.index].id
 # count            = length(aws_instance.app-server)
  port             = 80
  
}



