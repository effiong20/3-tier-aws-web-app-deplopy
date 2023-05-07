/*resource "aws_lb_target_group" "my-alb-target" {
  name             = "my-alb-target"
  port             = 80
  protocol         = "HTTP"
 // target_type      = "instance"
  target_type      = "alb"
  vpc_id           =  module.vpc_module.vpc-id

 health_check {
  interval  = 10
  path      = "/"
  protocol  = "HTTP"
  timeout   = 3
  healthy_threshold = 3
  unhealthy_threshold = 2
}

resource "aws_lb" "my-alb" {
  name               = "my-alb"
 // load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb-sg.id}"]
 // subnets          = [aws_subnet.my-publicweb-subnet1.id ,aws_subnet.my-publicweb-subnet2.id]
  subnets            = [module.vpc_module.my-publicweb-subnet1.id ,module.vpc_module.my-publicweb-subnet2.id]
  enable_deletion_protection = false
}
 listener{
  load_balancer_arn = aws_lb.my-alb.arn
  instance_port = 80
  instance_protocol= "http"
  lb_port=  80
  lb_protocol= "http"
}
   health_check {
   interval  = 30
   target  = "http:80/"
   timeout   = 3
   healthy_threshold = 2
   unhealthy_threshold = 2
  }
 
 tags = {
    Environment = "my-alb-sample"
 }
}
*/



