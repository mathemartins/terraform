# configure for AWS Provider

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA4MTWMO4EZIVGYM7A"
  secret_key = "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"
}

# retrieve list of AZs(Availability Zones) in the region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

# define vpc - virtual private cloud
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
  }
}

# deploy the private subnets
resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  for_each          = var.private_subnets
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]
  tags = {
    Name      = each.key
    Terraform = "true"
  }
}

# deploy the public subnets
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  for_each                = var.public_subnets
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = true
  tags = {
    Name      = each.key
    Terraform = "true"
  }
}

# create route-table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name      = "demo_public_rtb"
    Terraform = "true"
  }
}

# create route-table for private subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name      = "demo_private_rtb"
    Terraform = "true"
  }
}

# create route-table association for public
resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public_route_table.id
  depends_on     = [aws_subnet.public_subnets]
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
}

# create route-table association for private
resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private_route_table.id
  depends_on     = [aws_subnet.private_subnets]
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
}

# create internet-gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "demo_igw"
  }
}

# create elastic IP Address for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "demo_igw_eip"
  }
}

# create nat-gateway
resource "aws_nat_gateway" "nat_gateway" {
  depends_on    = [aws_subnet.public_subnets]
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  tags = {
    Name = "demo-nat-gateway"
  }
}

# Terraform data block to lookup latest ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

# Terraform resource block to build EC2 instance in the public subnet
resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  tags = {
    Name = "Ubuntu EC2 Server"
  }
}

# provision an s3 resource on amazon
resource "aws_s3_bucket" "storage_bucket" {
  bucket = "my-new-terraform-test-${random_id.randomness.id}"

  tags = {
    Name    = "s3 bucket"
    Purpose = "intro to resource labs"
  }
}

# provision security group to be used later
resource "aws_security_group" "security_group" {
  name        = "web-server-inbound"
  description = "Allow inbound traffic on tcp/443"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow 443 from the internet"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  tags = {
    Name    = "web_server_inbound"
    Purpose = "Intro to resource block lab"
  }
}

# provision a random resource locally to use to name certain things randomly
resource "random_id" "randomness" {
  byte_length = 1
}

# adding another subnet
resource "aws_subnet" "variables_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.250.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name      = "new-variable-subnet"
    Terraform = true
  }
}