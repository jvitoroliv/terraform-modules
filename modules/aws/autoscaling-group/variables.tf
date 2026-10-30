variable "name" {
  description = "The name of the Auto Scaling group"
  type        = string
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 0
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "health_check_grace_period" {
  description = "Time in seconds after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "Type of health check to perform. Values are EC2 or ELB"
  type        = string
  default     = "ELB"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch instances in"
  type        = list(string)
}

variable "target_group_arns" {
  description = "A list of target group ARNs to associate with the Auto Scaling group"
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scaling group should be terminated"
  type        = list(string)
  default     = ["Default"]
}

variable "launch_template_id" {
  description = "The ID of the launch template to use"
  type        = string
}

variable "launch_template_version" {
  description = "Launch template version to use"
  type        = string
  default     = "$Latest"
}

variable "enabled_metrics" {
  description = "List of metrics to collect"
  type        = list(string)
  default = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
}

variable "tags" {
  description = "A map of tags to add to the Auto Scaling Group"
  type        = map(string)
  default     = {}
}