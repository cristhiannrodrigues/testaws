resource "aws_security_group" "promosapi_sg" {
  name        = "promos_sg"
  description = "promos security group"
  vpc_id      = aws_vpc.promos_vpc_1.id
}

resource "aws_security_group_rule" "srg_pub_out" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.promosapi_sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "srg_http_in" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.promosapi_sg.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "srg_ssh_in" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.promosapi_sg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_key_pair" "promos_key" {
  key_name   = "promo_key"
  public_key = file("/Users/cristhiannrodrigues/.ssh/promo_key.pub")
}