output "my-publicweb-subnet1-id" {
    value = aws_subnet.my-publicweb-subnet1.id
}

output "my-publicweb-subnet2-id" {
    value = aws_subnet.my-publicweb-subnet2.id
}

output "my-privatapp-subnet1-id" {
    value = aws_subnet.my-privatapp-subnet1.id
}

output "my-privatapp-subnet2-id" {
    value = aws_subnet.my-privatapp-subnet2.id
}

output "my-privatdb-subnet1-id" {
    value = aws_subnet.my-privatdb-subnet1.id
}

output "my-privatdb-subnet2-id" {
    value = aws_subnet.my-privatdb-subnet2.id
}

output "vpc-id" {
    value = aws_vpc.my-vpc.id
}