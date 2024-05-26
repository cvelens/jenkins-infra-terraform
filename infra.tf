resource "aws_vpc" "main" {
  cidr_block = var.vpccidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet_cidr
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "Public Subnet for Jenkins"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet Gateway for VPC ${var.vpc_name}"
  }
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "Public subnet route table"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_security_group" "jenkins" {
  name        = var.aws_security_group_name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  count             = length(var.jenkins_ingress_rules)
  from_port         = var.jenkins_ingress_rules[count.index].from_port
  to_port           = var.jenkins_ingress_rules[count.index].to_port
  protocol          = var.jenkins_ingress_rules[count.index].protocol
  cidr_blocks       = [var.jenkins_ingress_rules[count.index].cidr_block]
  description       = var.jenkins_ingress_rules[count.index].description
  security_group_id = aws_security_group.jenkins.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  count             = length(var.jenkins_egress_rules)
  from_port         = var.jenkins_egress_rules[count.index].from_port
  to_port           = var.jenkins_egress_rules[count.index].to_port
  protocol          = var.jenkins_egress_rules[count.index].protocol
  cidr_blocks       = [var.jenkins_egress_rules[count.index].cidr_block]
  description       = var.jenkins_egress_rules[count.index].description
  security_group_id = aws_security_group.jenkins.id
}

resource "aws_instance" "jenkins" {
  ami                         = var.ami_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  subnet_id                   = aws_subnet.public_subnet.id
  root_block_device {
    delete_on_termination = var.delete_on_termination
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
  }

  tags = {
    Name = var.ec2_instance_name
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.jenkins.id
  allocation_id = var.jenkins_eip
}