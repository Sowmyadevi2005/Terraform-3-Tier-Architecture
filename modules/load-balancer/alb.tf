# Create an Application Load Balancer (ALB)
resource "aws_lb" "app_lb" {
# Defining an AWS resource
  name               = var.alb_name
  internal           = false # Externally accessible
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets # Deploy in public subnets
}

# Define a target group for the ALB to route traffic to the application instances
resource "aws_lb_target_group" "tg" {
# Defining an AWS resource
  name        = var.lb_target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  # Health check to determine if instances are healthy
  health_check {
    path                = "/phpinfo.php"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  # Enable stickiness using ALB cookies
  stickiness {
    enabled = true
    type    = "lb_cookie"
  }
}

# Create an HTTP listener for the ALB
resource "aws_lb_listener" "http" {
# Defining an AWS resource
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  # Forward traffic to the target group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
