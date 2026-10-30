resource "aws_autoscaling_group" "this" {
  name                      = var.name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = var.target_group_arns
  termination_policies      = var.termination_policies
  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  enabled_metrics = var.enabled_metrics

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}