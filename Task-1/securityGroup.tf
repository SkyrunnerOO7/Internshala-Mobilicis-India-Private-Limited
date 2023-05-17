#========================aws_security_group==========================================
resource "aws_security_group" "dove_stack_sg" {
  name        = "dove-stack-sg"
  description = "Sec Grp for dove on port 80"
  vpc_id      = aws_vpc.dove.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_port_80"
  }
}
