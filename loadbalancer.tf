
# Application Load Balancer
resource "aws_lb" "LB1" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dynamicSG.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = {
    Environment = "dev-production-lb"
  }
}

# Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.LB1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WebServers.arn
  }
}


# Target Groups
resource "aws_lb_target_group" "WebServers" {
  name        = "lb-alb-tg1"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.MyVPC1.id
  health_check {
    enabled = true
    interval = 10
    matcher = 200
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "attach_instance1" {
  target_group_arn = aws_lb_target_group.WebServers.arn
  target_id        = aws_instance.ec2_instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_instance2" {
  target_group_arn = aws_lb_target_group.WebServers.arn
  target_id        = aws_instance.ec2_instance2.id
  port             = 80
}