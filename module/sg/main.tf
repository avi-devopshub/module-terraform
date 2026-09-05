resource "aws_security_group" "my_sg"{
    name = var.sg_name
    description = var.sg_name
    vpc_id = var.vpc_id
    ingress{
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = var.protocol
        cidr_blocks = var.cidr
    }
    ingress{
        from_port = var.http_port
        to_port = var.http_port
        protocol = var.protocol
        cidr_blocks = var.cidr
    }
    egress{
        from_port = var.egress_port
        to_port = var.egress_port
        protocol = var.egress_protocol
        cidr_blocks = var.cidr
    }

}