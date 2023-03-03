variable "subnet_id" {
  description = "ID of the subnet where the NAT Gateway should be created."
}

variable "route_table_id" {
  description = "ID of the route table to update."
}

resource "aws_eip" "my_eip" {
  vpc = true
}

resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "MyNatGateway"
  }
}

resource "aws_route" "my_route" {
  depends_on = [aws_nat_gateway.my_nat_gateway]
  route_table_id = var.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
}
