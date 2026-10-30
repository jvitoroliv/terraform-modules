# AWS Launch Template Module

This module creates an AWS EC2 Launch Template.

## Usage

```hcl
module "launch_template" {
  source = "../../modules/aws/launch-template"

  name          = "my-launch-template"
  description   = "Launch template for my application"
  image_id      = "ami-12345678"
  instance_type = "t3.micro"

  security_group_ids = ["sg-123456"]

  block_device_mappings = [
    {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = 30
        volume_type           = "gp3"
        delete_on_termination = true
        encrypted             = true
      }
    }
  ]

  tags = {
    Environment = "Production"
    Application = "MyApp"
  }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| name | The name of the launch template | string | null |
| name_prefix | Creates a unique name beginning with the specified prefix | string | null |
| description | Description of the launch template | string | null |
| image_id | The AMI ID to use for the launch template | string | - |
| instance_type | Instance type to use for the launch template | string | - |
| key_name | The key name to use for the instance | string | null |
| user_data_base64 | The Base64-encoded user data to provide when launching the instance | string | null |
| iam_instance_profile_arn | The IAM Instance Profile ARN to launch the instance with | string | "" |
| security_group_ids | A list of security group IDs to associate with | list(string) | [] |
| block_device_mappings | Specify volumes to attach to the instance besides the volumes specified by the AMI | list(object) | [] |
| network_interfaces | Customize network interfaces to be attached at instance boot time | list(object) | [] |
| enable_monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | bool | false |
| metadata_options | The metadata options for the instance | object | See variables.tf |
| tags | A map of tags to add to the launch template and resources | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the launch template |
| arn | The ARN of the launch template |
| latest_version | The latest version of the launch template |
| default_version | The default version of the launch template |
| name | The name of the launch template |