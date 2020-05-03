# terraform-aws-vault-cluster
Deploy and configure hashicorp vault. This repo maintains a collection of terraform modules for managing hashicorp vault.

* aws-auth - enable aws auth method for an  aws account
* aws-auth-method-role - create an aws auth method role
* pki-ca - create a pki secret engine with an existing CA
* pki-sub-ca - create an internediate CA and pki secret engine from an existing vault CA
* vault-k8s-cluster - deploy the hashicorp vault helm chart to a kubernetes cluster
