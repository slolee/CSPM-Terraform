resource "aws_instance" "cspm_instance" {
  ami = "ami-02af1a55fd4da5ab1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.cspm_subnet.0.id
  // key_name

  vpc_security_group_ids = [ aws_security_group.cspm_instance_sg.id ]
}
