resource "aws_security_group" "bastion" {
  name   = local.bastion_security_group
  vpc_id = var.vpc_id
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.bastion.id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  subnet_id                   = data.aws_subnets.current.ids[0]
  key_name                    = var.key_name
  user_data                   = file("user_data.sh")
  user_data_replace_on_change = true
}

resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {
  security_group_id = aws_security_group.bastion.id
  description       = "Allow SSH from external sources"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "bastion_egress" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

resource "aws_vpc_security_group_egress_rule" "bastion_to_cache" {
  security_group_id            = aws_security_group.bastion.id
  referenced_security_group_id = aws_security_group.cache.id
  from_port                    = 6379
  to_port                      = 6379
  ip_protocol                  = "tcp"
}
