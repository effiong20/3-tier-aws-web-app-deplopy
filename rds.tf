# AWS RDB
resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my_subnet_group"
  subnet_ids = [aws_subnet.my-privatdb-subnet1.id, aws_subnet.my-privatdb-subnet2.id]

  tags = {
    Name = "my_subnet_group"
  }
}

resource "aws_db_parameter_group" "param-group" {
  name   = "param-group"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.instance-sg.id]
 }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "rds-sg"
  }
}


resource "aws_db_instance" "default" {
  allocated_storage    = 30
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "admin123"
  parameter_group_name = aws_db_parameter_group.param-group.name
  skip_final_snapshot  = true
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  db_subnet_group_name = aws_db_subnet_group.my_subnet_group.name 
  storage_type         = "gp2"
  availability_zone    = aws_subnet.my-privatdb-subnet1.availability_zone
  backup_retention_period = 30
}
