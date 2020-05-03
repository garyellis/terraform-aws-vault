# terraform-aws-auth-method
Enable AWS auth method for an AWS account. *This module is a work in progress.*

## Requirements

* terraform v0.12+
* vault server v1.2+
* When the vault server is running on an EC2 instance - an attached iam instance profile attached that can describe ec2 instances and read iam role, user and profiles
* When the vault server is running on-premesis - an iam user with iam permission policy to describe ec2 instances and read iam role, user and profiles

## Providers

| Name | Version |
|------|---------|
| vault | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_access\_key | the vault aws auth method aws access key for on-premesis vault | `string` | `null` | no |
| aws\_iam\_instance\_profile\_arns | a list of iam instance profiles bound to the vault aws auth method role | `list(string)` | `[]` | no |
| aws\_iam\_role\_arns | a list of iam roles bound to the vault aws auth method role | `list(string)` | `[]` | no |
| aws\_region | the infered aws region | `string` | `"us-west-2"` | no |
| aws\_secret\_key | the vault aws auth method aws secret key for on-premesis vault | `string` | `null` | no |
| vault\_auth\_backend\_description | n/a | `string` | `"aws auth backend"` | no |
| vault\_auth\_backend\_path | n/a | `string` | `"aws"` | no |
| vault\_role\_name | the vault aws auth method role name | `string` | n/a | yes |
| vault\_server\_dns\_name | Configure the X-Vault-AWS-IAM-Server-ID value | `string` | n/a | yes |
| vault\_token\_policies | A list of existing token polciies associated to the vault role | `list(string)` | `[]` | no |

## Outputs

No output.
