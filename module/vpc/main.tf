#VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = var.my_vpc_cidr
    tags = {
        Name = var.vpc_name
    }
}
#Public Subnet
resource "aws_subnet" "public_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.public_az
     map_public_ip_on_launch = true s
    tags = {
        Name = var.public_subnet_name
    }
}
#Private Subnet
resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.public_az
    tags = {
        Name = var.private_subnet_name
    }
}
#Internet Gateway
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = var.igw_name
    }
}
#EIP
resource "aws_eip" "eip"{
    domain = var.eip-domain
    tags = {
        Name = var.eip_name
    }
}
#NAT
resource "aws_nat_gateway" "nat"{
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name = var.nat_name
    }
}
#Route Table Public
resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route{
        cidr_block = var.public_rt_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = var.public_rt_name
    }
}
#Public Route Table Association
resource "aws_route_table_association" "public_association"{
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet.id
}
#Route Table Private
resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route{
        cidr_block = var.priavte_rt_cidr
        gateway_id = aws_nat_gateway.nat.id
    }
    tags{
        Name = var.private_rt_name
    }
}
#Private Route Table Association
resource "aws_route_table_association" "private_association"{
    route_table_id = aws_route_table.private_rt_id
    subnet_id = aws_subnet.private_subnet.id
}
