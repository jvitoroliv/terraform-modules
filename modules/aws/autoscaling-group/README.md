# AWS Auto Scaling Group Module

This module creates an AWS Auto Scaling Group.

## Usage

```hcl
module "asg" {
  source = "../../modules/aws/autoscaling-group"

  name                      = "my-asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  subnet_ids                = ["subnet-123", "subnet-456"]
  target_group_arns         = ["arn:aws:elasticloadbalancing:..."]
  launch_template_id        = "lt-123456"
  launch_template_version   = "$Latest"

  tags = {
    Environment = "Production"
    Application = "MyApp"
  }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| name | The name of the Auto Scaling group | string | - |
| min_size | The minimum size of the Auto Scaling Group | number | 0 |
| max_size | The maximum size of the Auto Scaling Group | number | 3 |
| desired_capacity | The desired capacity of the Auto Scaling Group | number | 1 |
| health_check_grace_period | Time in seconds after instance comes into service before checking health | number | 300 |
| health_check_type | Type of health check to perform. Values are EC2 or ELB | string | "ELB" |
| subnet_ids | A list of subnet IDs to launch instances in | list(string) | - |
| target_group_arns | A list of target group ARNs to associate with the Auto Scaling group | list(string) | [] |
| termination_policies | A list of policies to decide how the instances in the auto scaling group should be terminated | list(string) | ["Default"] |
| launch_template_id | The ID of the launch template to use | string | - |
| launch_template_version | Launch template version to use | string | "$Latest" |
| enabled_metrics | List of metrics to collect | list(string) | See variables.tf |
| tags | A map of tags to add to the Auto Scaling Group | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| id | The Auto Scaling Group ID |
| name | The Auto Scaling Group name |
| arn | The ARN for this Auto Scaling Group |
| availability_zones | The availability zones of the Auto Scaling Group |
| min_size | The minimum size of the Auto Scaling Group |
| max_size | The maximum size of the Auto Scaling Group |
| desired_capacity | The number of instances that should be running in the group |
| default_cooldown | The default cooldown for this Auto Scaling Group |
| health_check_type | The health check type for the Auto Scaling Group |
| health_check_grace_period | The health check grace period for the Auto Scaling Group |