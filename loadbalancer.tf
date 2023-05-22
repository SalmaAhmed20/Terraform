resource "aws_lb_target_group" "node_app_tg" {
  name     = "node-app-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.networks.VPCID
}
resource "aws_lb_target_group_attachment" "appAZ1" {
  target_group_arn = aws_lb_target_group.node_app_tg.arn
  target_id        = aws_instance.application.id
  port             = 3000
}
resource "aws_lb_target_group_attachment" "appAZ2" {
  target_group_arn = aws_lb_target_group.node_app_tg.arn
  target_id        = aws_instance.application2.id
  port             = 3000
}
resource "aws_lb" "node_app_alb" {
    name = "node-app-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups = [ module.networks.lb_sg_id ]
    subnets = [ module.networks.PubsubnetID1, module.networks.PubsubnetID2 ]
}
resource "aws_lb_listener" "node_app" {
  load_balancer_arn = aws_lb.node_app_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node_app_tg.arn
  }
}