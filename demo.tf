# Configure and downloading plugins for aws
provider "aws" {
region = "ap-southeast-2"
}

resource "aws_instance" "test" {
ami = "ami-60a26a02"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.instance.id]
key_name = "admin"
// connection {
// type = "ssh"
// host = self.public_ip
// user = "ubuntu"
// private_key = file("/home/angela/Kalepa/terraform/conf/aws_key")
// timeout = "4m"
// }
user_data = <<-EOF

          #!/bin/bash
          echo "Hello, World" > index.html
          nohup busybox httpd -f -p 8080 &
EOF
}

resource "aws_key_pair" "angela" {
key_name = "admin"
//public_key = file("/go/src/github.com/hashicorp/terraform/conf/aws_key.pub")
public_key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC48IXrfAAJy2cSPqx5icMdbNDR5okYCZBoLud6lf4W9Idhyj2/TKG2xr4cluYS71EFycQIZyJd4K5XxsOOdGKo7QgeJUNcU9YhO5QdsAPBljRuQtxzVLKwWngSpcKjM8T/Tjkp4gZoUmpbUvzaB12+jfBPO4H9JpXcSt8366D3AyOK9vCa2UjRVkDMCSFN5rTslVCcekCJUygYKyhhn3orAwsm9E4DAeF7xErY77P3S+VLUctDOVp7bCMLrhwci/nvrCleWQckyYuY5F/PaXB4CtJCaoHtQLuMc2l8RNSWeX4veCFN4rQWHRfwVr4eluJOZWKwSq51N65pRSsKHf6Dbash-5.1'
}

resource "aws_security_group" "instance" {
name = "terraform-example-instance"

ingress {
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}

