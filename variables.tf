variable "profile" {
  type        = string
  default     = "infra"
  description = "Account in which the resources will be deployed"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region where the resources will be deployed"
}

variable "vpc_name" {
  type    = string
  default = "csye7125_jenkins"
}

variable "vpccidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
  validation {
    condition     = contains(["10.0.0.0/16", "192.168.0.0/16", "172.31.0.0/16"], var.vpccidr)
    error_message = "Please enter a valid CIDR. Allowed values are 10.0.0.0/16, 192.168.0.0/16 and 172.31.0.0/16"
  }
}

variable "public_subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "Public subnet for VPC"
}

variable "jenkins_eip" {
  type        = string
  default     = "eipalloc-042f80120e4724834"
  description = "Jenkins EIP Allocation ID"
}

variable "ami_id" {
  type        = string
  description = "AWS AMI ID"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 Instance Type"
}

variable "ec2_instance_name" {
  type        = string
  default     = "csye7125_jenkins"
  description = "EC2 Instance Name"
}

variable "ebs_volume_size" {
  type        = string
  default     = 20
  description = "EBS Volume Size"
}

variable "ebs_volume_type" {
  type        = string
  default     = "gp2"
  description = "EBS Volume Type"
}

variable "jenkins_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))

  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "HTTPS"
    }
  ]
}

variable "delete_on_termination" {
  type    = string
  default = true
}

variable "associate_public_ip_address" {
  type    = string
  default = true
}

variable "aws_security_group_name" {
  type    = string
  default = "jenkins"
}

variable "jenkins_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))

  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "Outbound HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "Outbound HTTPS"
    }
  ]
}