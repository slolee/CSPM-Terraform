resource "aws_db_subnet_group" "cspm_subnet_group" {
  name = "cspm_subnet_group"
  subnet_ids = aws_subnet.cspm_subnet.*.id
}

resource "aws_db_instance" "cspm_db" {
  allocated_storage = 20
  max_allocated_storage = 100
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t2.micro"
  name = "cspm_db"
  username = "ch4njun"
  password = "cks14579!"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true

  vpc_security_group_ids = [ aws_security_group.cspm_db_sg.id ]
  db_subnet_group_name = aws_db_subnet_group.cspm_subnet_group.name
}