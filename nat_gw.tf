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