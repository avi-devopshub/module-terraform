resource "aws_instance" "my_ec2"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.public_subnet_id
    vpc_security_group_ids = [var.sg_id]
    user_data = filebase64("/root/module-terraform/module/ec2/user_data.sh")

}