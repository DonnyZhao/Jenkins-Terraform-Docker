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
public_key = file("/go/src/github.com/hashicorp/terraform/conf/aws_key.pub")
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

