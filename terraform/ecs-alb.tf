resource "aws_alb" "main" {
  
  name = "${var.name_prefix}-webapp-alb"
  subnets = [ "${aws_subnet.subnet.*.id}" ]
  security_groups = ["${aws_security_group.webapp_albs.id}"]
  idle_timeout = 400
  tags {
        Name = "${var.name_prefix}_webapp_alb"
  }
  lifecycle {
    create_before_destroy = true 
    }
}

resource "aws_alb_target_group" "webapp_tg" {
  name                 = "${var.name_prefix}-webapp-tg"
  port                 = "5000"
  protocol             = "HTTP"
  vpc_id               = "${aws_vpc.main.id}"

  deregistration_delay = 180

  health_check {
    interval            = "60"
    path                = "/"
    port                = "5000"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
  }

  tags {
        Name = "${var.name_prefix}_webapp_tg"
  }

  depends_on = ["aws_alb.main"]
}

resource "aws_alb_listener" "frontend_http" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.webapp_tg.id}"
    type             = "forward"
  }

  depends_on = ["aws_alb.main"]
}
