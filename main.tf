module "vpc"{
    source = "./module/vpc"
    my_vpc_cidr = "10.0.0.0/16"
    vpc_name = "my_vpc"
    public_subnet_cidr = "10.0.0.0/20"
    public_subnet_name = "public-subnet"
    private_subnet_cidr = "10.0.16.0/20"
    private_subnet_name = "private-subnet"
    igw_name = "IGW"
    public_az = "ap-south-1a"
    private_az = "ap-south-1b"
    eip_domain = "vpc"
    eip_name = "nat-eip"
    nat_name = "my-nat"
    public_rt_cidr = "0.0.0.0/0"
    public_rt_name = "public-rt"
    priavte_rt_cidr = "0.0.0.0/0"
    private_rt_name = "private-rt"
}

module "sg"{
    source = "./module/sg"
    vpc_id = module.vpc.vpc_id
    sg_name = "my-sg"
    ssh_port = 22
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    http_port = 80
    egress_port = 0
    egress_protocol = "-1"
}

module "ec2"{
    source = "./module/ec2"
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.micro"
    key_name = "mumbai"
    public_subnet_id = module.vpc.public_subnet_id
    sg_id = module.sg.sg_id
}