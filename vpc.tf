resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}
resource "aws_internet_gateway" "my-gw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-gw"
  }
}

##CREATE PUBLIC SUBNET GROUP
resource "aws_subnet" "my-publicweb-subnet1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

 tags = {
    Name = "my-publicweb-subnet1"
  }
}

resource "aws_subnet" "my-publicweb-subnet2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

 tags = {
    Name = "my-publicweb-subnet2"
  }
}

###CREATE PRIVATE SUBNET FOR APP SERVER 
resource "aws_subnet" "my-privatapp-subnet1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  
tags = {
    Name = "my-privatapp-subnet1"
  }
}

resource "aws_subnet" "my-privatapp-subnet2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  
tags = {
    Name = "my-privatapp-subnet2"
  }
}

##CREATE MY DATABASE PRIVATE SUBNET 
resource "aws_subnet" "my-privatdb-subnet1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1a"
  
tags = {
    Name = "my-privatdb-subnet1"
  }
}

resource "aws_subnet" "my-privatdb-subnet2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1b"
  
tags = {
    Name = "my-privatdb-subnet2"
  }
}

##CREATE ROUT TABLE FOR WEB SERVER
resource "aws_route_table" "web-public-routtable" {
  vpc_id = aws_vpc.my-vpc.id

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gw.id
  }
  tags = {
    Name = "web-public-routtable"
  }
}

resource "aws_route_table" "app-private-routtable" {
  vpc_id = aws_vpc.my-vpc.id
 
 route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my-natgw.id
  }
  tags = {
    Name = "app-private-routtable"
  }
}

resource "aws_route_table" "db-private-routtable" {
  vpc_id = aws_vpc.my-vpc.id

route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my-natgw.id
  }
  tags = {
    Name = "db-private-routtable"
  }
}

resource "aws_route_table_association" "web-rout-associat-subnet1" {
  subnet_id      = aws_subnet.my-publicweb-subnet1.id
  route_table_id = aws_route_table.web-public-routtable.id
}

resource "aws_route_table_association" "web-rout-associat-subnet2" {
  subnet_id      = aws_subnet.my-publicweb-subnet2.id
  route_table_id = aws_route_table.web-public-routtable.id
}

resource "aws_route_table_association" "app-rout-associat-subnet1" {
  subnet_id      = aws_subnet.my-privatapp-subnet1.id
  route_table_id = aws_route_table.app-private-routtable.id
}

resource "aws_route_table_association" "app-rout-associat-subnet2" {
  subnet_id      = aws_subnet.my-privatapp-subnet2.id
  route_table_id = aws_route_table.app-private-routtable.id
}

resource "aws_route_table_association" "db-rout-associat-subnet1" {
  subnet_id      = aws_subnet.my-privatdb-subnet1.id
  route_table_id = aws_route_table.db-private-routtable.id
}

resource "aws_route_table_association" "db-rout-associat-subnet2" {
  subnet_id      = aws_subnet.my-privatdb-subnet2.id
  route_table_id = aws_route_table.db-private-routtable.id
}

