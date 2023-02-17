resource "aws_vpc" "promos_vpc_1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" : "promos_vpc_1"
  }
}

resource "aws_subnet" "promos_subnet" {
  vpc_id                  = aws_vpc.promos_vpc_1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "sa-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "promos_subnet_pub"

  }
}

resource "aws_internet_gateway" "promos_internet_gateway" {
  vpc_id = aws_vpc.promos_vpc_1.id

  tags = {
    "Name" = "promos_igw"
  }
}

resource "aws_route_table" "promos_rtb" {
  vpc_id = aws_vpc.promos_vpc_1.id

  tags = {
    "Name" = "promos_rtb"
  }
}

resource "aws_route" "promos_route" {
  route_table_id         = aws_route_table.promos_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.promos_internet_gateway.id
}

resource "aws_route_table_association" "promos_rtb_ass" {
  route_table_id = aws_route_table.promos_rtb.id
  subnet_id      = aws_subnet.promos_subnet.id
}

resource "aws_instance" "promos_ec2" {
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.promos_key.id
  vpc_security_group_ids = [aws_security_group.promosapi_sg.id]
  subnet_id              = aws_subnet.promos_subnet.id

  ami = data.aws_ami.promos_ami.id

  user_data = file("userdata.tpl")

  tags = {
    Name = "promos_ec2"
  }
}