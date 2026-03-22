resource "aws_instance" "public_ec2" {
  ami           = "ami-0ec10929233384c7f" 
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name = "myjob744-kp" 
  user_data = base64encode(<<EOF
  #!/bin/bash
  set -e
  apt-get update -y
  snap install amazon-ssm-agent --classic 
  systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
  systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent.service
  EOF
  )

  tags = {
    Name = "public-ec2"
  }
}

resource "aws_instance" "private_ec2" {
  ami           = "ami-0ec10929233384c7f" 
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name = "myjob744-kp" 
   user_data = base64encode(<<EOF
  #!/bin/bash
  set -e
  apt-get update -y
  snap install amazon-ssm-agent --classic 
  systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
  systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent.service
  EOF
  )
  tags = {
    Name = "private-ec2"
  }
}