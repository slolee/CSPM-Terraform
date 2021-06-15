resource "aws_security_group" "cspm_instance_sg" {
  name = "cspm_instance_security_group"
  vpc_id = aws_vpc.cspm_vpc.id

  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "SSH"
    from_port = 22
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "tcp"
    security_groups = null
    self = false
    to_port = 22
  }, {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "CSPM Service Port"
    from_port = 10831
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "tcp"
    security_groups = null
    self = false
    to_port = 10831
  } ]

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Default"
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = -1
    security_groups = null
    self = false
    to_port = 0
  } ]
}

resource "aws_security_group" "cspm_db_sg" {
  name = "cspm_db_security_group"
  vpc_id = aws_vpc.cspm_vpc.id

  ingress = [ {
    cidr_blocks = null
    description = "MySQL"
    from_port = 3306
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "tcp"
    security_groups = [ aws_security_group.cspm_instance_sg.id ]
    self = false
    to_port = 3306
  } ]

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Default"
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = -1
    security_groups = null
    self = false
    to_port = 0
  } ]
}