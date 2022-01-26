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
public_key='
PuTTY-User-Key-File-2: ssh-rsa
Encryption: none
Comment: imported-openssh-key
Public-Lines: 6
AAAAB3NzaC1yc2EAAAADAQABAAABAQC48IXrfAAJy2cSPqx5icMdbNDR5okYCZBo
Lud6lf4W9Idhyj2/TKG2xr4cluYS71EFycQIZyJd4K5XxsOOdGKo7QgeJUNcU9Yh
O5QdsAPBljRuQtxzVLKwWngSpcKjM8T/Tjkp4gZoUmpbUvzaB12+jfBPO4H9JpXc
St8366D3AyOK9vCa2UjRVkDMCSFN5rTslVCcekCJUygYKyhhn3orAwsm9E4DAeF7
xErY77P3S+VLUctDOVp7bCMLrhwci/nvrCleWQckyYuY5F/PaXB4CtJCaoHtQLuM
c2l8RNSWeX4veCFN4rQWHRfwVr4eluJOZWKwSq51N65pRSsKHf6D
Private-Lines: 14
AAABAGdyElaf652O6r5n1C2/gyYIYd2m5/RMFTxRUCVflNreOIPYjiVdBe+ox1pS
har9tgJY05AnsC92p85tXaFnNHBs9Wd3THBubI32N2lLtS4piHZMa+cO70x5rkQv
9+k14fE0ngDxbsgXoWonx0tlZ2hZGJwZGyKw3I52StmKsWS4prp0XmhJn8REBmRs
mrx7TEWZQcisczK/8fC0UYgOhzWnHO7mGt38qZDIZL9sAw4/gcU5BZdt9TOJPto9
GmqkaorScnJb2mKGxnAaORDylKqQsd/+a5pFEFAZcryWc/tOnBIQtHTRm5hV584Z
3fUT/OSjoaaAckY2PDVc3vgNgxEAAACBAOllPPToOHRaVjuT9n6R+uRDGfKXXhTd
HHxbrLo1oJyv/qy48i+6pqjY//FPoD6vwYZPp+6UyThyTZOxz8US426/X3flJEpW
47x9EU1bnnrDpSGJY6w9x/L55ke8xVjCPga/JD7XrJSXo3j48zuMom8NTRNbFMyZ
bSMEq8vSDFTfAAAAgQDK2eDccvsOVKSTAhyO3ZE4Y2KYH3bJ+sUEXa86rFLInNe9
i2MwrSxIDyaVHuCD8WN1gbLdckka3DLWVaou0JHW0zBmvqXESbTctNPjUdd2f/Ee
gxWWLEaVDeUeIV62moRLZXS7MKfWxMKcd1soS5NsDpKogsUbl+FgpJoftHSG3QAA
AIApRe0TlWnQh+/qZMQUWJF29D59FXghULZA/oeQOK7R3hNMtwJhudnzKTdOw9G4
h+IEwACXS7F3Xpbm9TiSbxcGQ/HA3zajtx8rga5lUau5OSEebqYhjASuKxodBxtE
Z6206rXeNIJ8MO8N/iw1Rl7dUc277PrD6sPtX8cCkD5rrQ==
Private-MAC: b9f8e604d3c2b37f4c30f03fb2e437f881252fa4'
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

