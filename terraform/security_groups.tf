data "aws_vpc" "default_vpc_data" {
  default = true
}

resource "aws_security_group" "db_server_sg" {
  name        = "db_server_sg"
  vpc_id      = data.aws_vpc.default_vpc_data.id

  tags = {
    Name = "db_server_sg"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db_server_sg.id
}

resource "aws_security_group_rule" "allow_mysql" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default_vpc_data.cidr_block]
  security_group_id = aws_security_group.db_server_sg.id
}

resource "aws_security_group_rule" "allow_http_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db_server_sg.id
}

resource "aws_security_group_rule" "allow_all_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db_server_sg.id
}