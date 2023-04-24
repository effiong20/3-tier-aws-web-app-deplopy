resource "aws_instance" "app-server" {
  ami               = "ami-02396cdd13e9a1257"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id         = aws_subnet.my-privatapp-subnet1.id
  count             = 2
  user_data         = file("install_apache.sh")
  key_name          = "my-key"
  vpc_security_group_ids = ["${aws_security_group.my-sg.id}"]
  
 
  tags = {
    Name = "${count.index}-app-server"
  }
}

#BASTIAN-HOST SERVER

resource "aws_instance" "jump-server" {
  ami               = "ami-02396cdd13e9a1257"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id         = aws_subnet.my-publicweb-subnet1.id
  key_name          = "my-key"
  vpc_security_group_ids = [aws_security_group.jump-sg.id]
  
 
  tags = {
    Name = "jump-server"
  }
}
