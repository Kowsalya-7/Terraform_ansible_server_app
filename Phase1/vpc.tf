resource "aws_vpc" "cloud_hustlers_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "cloud_hustlers_vpc" }
}

resource "aws_subnet" "cloud_hustlers_subnet" {
  vpc_id                  = aws_vpc.cloud_hustlers_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"
  tags = { Name = "cloud_hustlers_subnet" }
}

resource "aws_internet_gateway" "cloud_hustlers_igw" {
  vpc_id = aws_vpc.cloud_hustlers_vpc.id
}

resource "aws_route_table" "cloud_hustlers_route_table" {
  vpc_id = aws_vpc.cloud_hustlers_vpc.id
}

resource "aws_route" "cloud_hustlers_route" {
  route_table_id         = aws_route_table.cloud_hustlers_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cloud_hustlers_igw.id
}

resource "aws_route_table_association" "cloud_hustlers_association" {
  subnet_id      = aws_subnet.cloud_hustlers_subnet.id
  route_table_id = aws_route_table.cloud_hustlers_route_table.id
}

resource "aws_security_group" "cloud_hustlers_sg" {
  vpc_id = aws_vpc.cloud_hustlers_vpc.id
  name   = "cloud_hustlers_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}