# Creating two EC2 instances
resource "aws_instance" "Mobilicis_Server" {
  count         = 2
  instance_type = "t2.micro"
  ami           = var.AMIS[var.REGION]

  subnet_id        = aws_subnet.dove-pub-1.id
  vpc_security_group_ids = [aws_security_group.dove_stack_sg.id]
}

# Creating a load balancer
resource "aws_elb" "Mobilicis_load_balancer" {
  name               = "Mobilicis-load-balancer"
  subnets            = [aws_subnet.dove-pub-1.id]
  security_groups    = [aws_security_group.dove_stack_sg.id]
  instances          = aws_instance.Mobilicis_Server[*].id
  cross_zone_load_balancing   = true
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }
  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }
}

output "load_balancer_dns" {
  value = aws_elb.Mobilicis_load_balancer.dns_name
}





