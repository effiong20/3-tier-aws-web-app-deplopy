
resource "aws_security_group" "instance-sg" {
  name        = "instance-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc_module.vpc-id
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
   security_groups = [aws_security_group.alb-sg.id]
 }

 ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  //security_groups  = [aws_security_group.jump-sg.id]
 }

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   tags = {
      Name = "my-sg"
   }
}

resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow TLS inbound traffic"
 // vpc_id      = aws_vpc.my-vpc.id
// vpc_id       = output.vpc-id
 vpc_id         =  module.vpc_module.vpc-id
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_tls"
  }
}






