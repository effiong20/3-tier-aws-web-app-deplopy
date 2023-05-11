resource "aws_vpc" "my-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
 // enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support    = var.enable_dns_support
  
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
  cidr_block = var.my-publicweb-subnet1-cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

 tags = {
    Name = "my-publicweb-subnet1"
  }
}

resource "aws_subnet" "my-publicweb-subnet2" {
  vpc_id     =aws_vpc.my-vpc.id
  cidr_block = var.my-publicweb-subnet2-cidr
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = var.map_public_ip_on_launch

 tags = {
    Name = "my-publicweb-subnet2"
  }
}

###CREATE PRIVATE SUBNET FOR APP SERVER 
resource "aws_subnet" "my-privatapp-subnet1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.my-privatapp-subnet1-cidr
  availability_zone = "us-east-1a"
  
tags = {
    Name = "my-privatapp-subnet1"
  }
}

resource "aws_subnet" "my-privatapp-subnet2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.my-privatapp-subnet2-cidr
  availability_zone = "us-east-1b"
  
tags = {
    Name = "my-privatapp-subnet2"
  }
}

##CREATE MY DATABASE PRIVATE SUBNET 
resource "aws_subnet" "my-privatdb-subnet1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.my-privatdb-subnet1-cidr
  availability_zone = "us-east-1a"
  
tags = {
    Name = "my-privatdb-subnet1"
  }
}

resource "aws_subnet" "my-privatdb-subnet2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.my-privatdb-subnet2-cidr
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

resource "aws_eip" "my-eip" {
  vpc      = true
}
resource "aws_nat_gateway" "my-natgw" {
  allocation_id = aws_eip.my-eip.id
  subnet_id     = aws_subnet.my-publicweb-subnet1.id
  depends_on    = [aws_internet_gateway.my-gw]
 
  tags = {
    Name = "gw-natgw"
  }
}
