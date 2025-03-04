# Define the Virtual Private Cloud (VPC)
resource "aws_vpc" "vpc" {
# Defining an AWS resource
  cidr_block = var.vpc_cidr  # CIDR block for the VPC, defined in variables
# Declaring input variable for module
  tags = {
    "Name" = "3-tier-VPC"  # Name tag for identification
  }
}

# Define Public Subnets
resource "aws_subnet" "public_subnets" {
# Defining an AWS resource
  count = length(var.public_subnets_cidr)  # Creates multiple subnets based on variable length
# Declaring input variable for module

  vpc_id            = aws_vpc.vpc.id  # Associate subnet with the VPC
  cidr_block        = var.public_subnets_cidr[count.index]  # Assigns CIDR block from variable list
# Declaring input variable for module
  availability_zone = var.availability_zones[count.index]  # Assigns an availability zone

  tags = {
    "Name" = "public_subnets"  # Name tag for public subnets
  }
}

# Define Private Application Subnets
resource "aws_subnet" "private_app_subnets" {
# Defining an AWS resource
  count             = length(var.private_app_subnets_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_app_subnets_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    "Name" = "private_app_subnets"
  }
}

# Define Private Database Subnets
resource "aws_subnet" "private_db_subnets" {
# Defining an AWS resource
  count             = length(var.private_db_subnets_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_db_subnets_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    "Name" = "private_db_subnets"
  }
}

# Create an Internet Gateway for public internet access
resource "aws_internet_gateway" "ig" {
# Defining an AWS resource
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "3-Tier-ig"
  }
}

# Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "eip" {
# Defining an AWS resource
  domain = "vpc"
}

# Create a NAT Gateway to allow private instances to access the internet
resource "aws_nat_gateway" "natgateway" {
# Defining an AWS resource
  subnet_id     = aws_subnet.public_subnets[0].id  # Place the NAT gateway in the first public subnet
  allocation_id = aws_eip.eip.id  # Attach the Elastic IP
  tags = {
    "Name" = "3-Tier-Natgateway"
  }
  depends_on = [aws_internet_gateway.ig]  # Ensures IGW is created first
# Explicit dependency configuration
}

# Define a Public Route Table
resource "aws_route_table" "public_rt" {
# Defining an AWS resource
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"  # Routes all outbound traffic to the internet
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "public_rt_as" {
# Defining an AWS resource
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Define a Private Route Table for Application Layer
resource "aws_route_table" "private_app_rt" {
# Defining an AWS resource
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway.id  # Routes traffic through NAT Gateway
  }
  tags = {
    Name = "private-app-route-table"
  }
}

# Associate Private App Subnets with the Private Route Table
resource "aws_route_table_association" "private_app_rt_as" {
# Defining an AWS resource
  count          = length(var.private_app_subnets_cidr)
  subnet_id      = element(aws_subnet.private_app_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_app_rt.id
}

# Define a Private Route Table for Database Layer
resource "aws_route_table" "private_db_rt" {
# Defining an AWS resource
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway.id  # Ensures DB layer has outbound access
  }
  tags = {
    Name = "private-db-route-table"
  }
}

# Associate Private Database Subnets with the Private Route Table
resource "aws_route_table_association" "private_db_rt_as" {
# Defining an AWS resource
  count = length(var.private_db_subnets_cidr)

  subnet_id      = element(aws_subnet.private_db_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_db_rt.id
}
