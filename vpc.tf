resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    name = "dev-vpc"
  }
}

resource "aws_subnet" "demo-vpc-public-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    name = "public-subnet"
  }
}

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
}

resource "aws_route_table" "dev-vpc-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }
}

resource "aws_route_table_association" "rt-association" {
  route_table_id = aws_route_table.dev-vpc-rt.id
  subnet_id = aws_subnet.demo-vpc-public-subnet.id
}