resource "aws_lb" "my-alb" {
  name                       = "my-alb"
  load_balancer_type         = "application"
  security_groups            = ["${aws_security_group.alb-sg.id}"]
  subnets                    = ["${module.vpc_module.my-publicweb-subnet1-id}" ,"${module.vpc_module.my-publicweb-subnet2-id}"]
  enable_deletion_protection = false
tags = {
    Environment = "my-alb-sample"
 }
}
resource "aws_lb_target_group" "my-alb-target" {
  name             = "my-alb-target"
  port             = 80
  protocol         = "HTTP"
  vpc_id           =  module.vpc_module.vpc-id
}
resource "aws_lb_listener" "my-listen" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-alb-target.arn
  }
}

output "alb_dns_name"{
   value = aws_lb.my-alb.dns_name
}

output "vpc-id" {
  value = module.vpc_module.vpc-id
}





