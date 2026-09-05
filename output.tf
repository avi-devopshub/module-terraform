output "vpc_id"{
    value = module.vpc.my_vpc.id
}
output "public_subnet_id"{
    value = module.vpc.public_subnet.id
}
output "private_subnet_id"{
    value = module.vpc.private_subnet.id
}