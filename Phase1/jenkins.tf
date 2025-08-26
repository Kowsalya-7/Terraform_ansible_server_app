resource "aws_instance" "jenkins_server" {
  ami           = "ami-0a716d3f3b16d290c" 
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.cloud_hustlers_subnet.id
  security_groups = [aws_security_group.cloud_hustlers_sg.id]
  key_name      = "cloudhustlers"  # replace with your AWS key pair

  tags = { Name = "cloudhustlers-jenkins-server" }
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}
