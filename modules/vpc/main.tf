# VPC
resource "aws_vpc" "boussad_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name           = "boussad_vpc"
  }

}

# PUBLIC SUBNETS
resource "aws_subnet" "boussad_public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.boussad_vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.availability_zone_names[count.index]
  map_public_ip_on_launch = true
}

# PRIVATE SUBNETS
resource "aws_subnet" "boussad_privaye_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.boussad_vpc.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zone_names[count.index]
  map_public_ip_on_launch = false
}

# INTERNET GETEWAY
resource "aws_internet_gateway" "boussad_gw" {
 vpc_id = aws_vpc.boussad_vpc.id 
}

#PUBLIC ROUTE TABLE
resource "aws_route_table" "boussad_public_route" {
  vpc_id = aws_vpc.boussad_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.boussad_gw.id
  }
  tags = {
    Name = "boussad_public_route"
  }
}

# ROUTE ASSOCIATION PUBLIC
resource "aws_route_table_association" "public_association" {
  count: 2
  subnet_id = aws_subnet.boussad_public_subnet[count.index].id
  route_table_id = aws_route_table.boussad_public_route.id
}

# NAT GATEWAY
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.boussad_public_subnet[0].id
  depends_on = [aws_internet_gateway.boussad_gw]
}

# PRIVATE ROUTE TABLE
resource "aws_route_table" "boussad_private_route" {
  vpc_id = aws_vpc.boussad.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.boussad_gw.id
  }
  tags = {
    Name = "boussad_private_route"
  }
}

# ROUTE ASSOCIATION PRIVATE
resource "aws_route_table_association" "private_association" {
  count: 2
  subnet_id = aws_subnet.boussad_private_subnet[count.index].id
  route_table_id = aws_route_table.boussad_private_route.id
}