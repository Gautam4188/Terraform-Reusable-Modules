data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {

    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }

  filter {

    name = "virtualization-type"

    values = ["hvm"]
  }
}

resource "aws_instance" "this" {

  ami = data.aws_ami.ubuntu.id

  instance_type = "t3.small"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  associate_public_ip_address = true

  root_block_device {

    volume_size = 8
    volume_type = "gp2"
  }

  user_data = <<-EOF
#!/bin/bash
apt update -y
apt install -y nginx
systemctl enable nginx
systemctl start nginx
EOF

  tags = {
    Name = "tester-vm"
  }
}