# terraform-k8s-vault-cluster
Deploy a vault cluster on an existing kubernetes cluster. The following resources are created by this module:

* Consul namespace and hashicorp consul helm chart deployment
* Vault namespace and hashicorp vault helm chart deployment
* Vault ingress to vault
* Vault endpoint awsroute53 private alias record mapped to the cluster ingress controller

## Requirements

* terraform v0.12
* a kubernetes cluster
* k8s cloud provider enabled to create pv and pvc resoureces

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| helm | n/a |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_server\_url | the kube apiserver url | `string` | n/a | yes |
| ca\_crt | the apiserver cacert | `string` | n/a | yes |
| client\_cert | the apiserver client certificate | `string` | n/a | yes |
| client\_key | the apiserver client key | `string` | n/a | yes |
| dns\_domain\_name | n/a | `string` | n/a | yes |
| dns\_name | n/a | `string` | n/a | yes |
| dns\_zone\_id | n/a | `string` | n/a | yes |
| hyperkube\_image | n/a | `string` | `"rancher/hyperkube"` | no |
| hyperkube\_image\_tag | n/a | `string` | `"v1.17.4-rancher1"` | no |
| ingress\_lb\_dns\_name | The load balancer dns name | `string` | n/a | yes |
| ingress\_lb\_zone\_id | The ingress load balancer zone id | `string` | n/a | yes |
| initial\_node\_count | n/a | `number` | `1` | no |
| service\_account\_name | run kubernetes jobs as this service account | `string` | `""` | no |
| tls\_cert | n/a | `string` | n/a | yes |
| tls\_key | n/a | `string` | n/a | yes |
| vault\_helm\_repo | n/a | `string` | `"https://charts.jetstack.io"` | no |
| vault\_version | n/a | `string` | `"0.12.0"` | no |

## Outputs

No output.
