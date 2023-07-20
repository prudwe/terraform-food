#FOOD Infra setup

resource "aws_vpc" "food" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "FOOD-VPC"
  }
}


# Create Subnet for FOOD VPC

resource "aws_subnet" "food-subnet" {
  vpc_id     = aws_vpc.food.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "FOOD-SUBNET"
  }
}


# Create Internet gateway 
resource "aws_internet_gateway" "food-igw" {
  vpc_id = aws_vpc.food.id

  tags = {
    Name = "FOOD-IGW"
  }
}

#Create Route Table

resource "aws_route_table" "food-rt" {
  vpc_id = aws_vpc.food.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.food-igw.id
  }

  tags = {
    Name = "FOOD-RT"
  }
}

# Route table association with subnet 

resource "aws_route_table_association" "food-rt-association" {
  subnet_id      = aws_subnet.food-subnet.id
  route_table_id = aws_route_table.food-rt.id
}

