# approle
Configure a Vault Approle role for on-premises system or app integration with terraform. This terraform module creates the following resources:

* optional vault pki secret backend role
* optional vault ssh secret backend role (for an on-premises CD agent, not an application approle)
* vault policy with access to parameterized list of kv paths and the pki secret backend role
* vault approle
* approle policy associations to in-module policy and parameterized list of policies


## Terraform version

* v0.12

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | A unique name applied to all resources | `string` | n/a | yes |
| vault\_approle\_auth\_backend\_path | the approle backend mount path | `string` | `"approle"` | no |
| vault\_approle\_secret\_metadata | A map of metadata key-value pairs set on tokens issued with the secret id | `map(string)` | `{}` | no |
| vault\_count\_approle\_wrapping\_tokens | The number of wrapping tokens to generate | `number` | `1` | no |
| vault\_create\_approle\_auth\_role | Creates vault approle role | `bool` | `true` | no |
| vault\_create\_pki\_secret\_backend\_role | Creates the pki secret back end role | `bool` | `true` | no |
| vault\_create\_ssh\_secret\_backend\_role | Creates the pki secret back end role | `bool` | `false` | no |
| vault\_kv\_paths | A list of Vault KV allowed paths. | `list(string)` | `[]` | no |
| vault\_pki\_role\_allowed\_domains | A list of allowed domains for certificates | `list(string)` | <pre>[<br>  "foo.bar"<br>]</pre> | no |
| vault\_pki\_role\_key\_bits | The PKI role key length | `number` | `4096` | no |
| vault\_pki\_role\_key\_usage | The PKI role key usages | `list(string)` | <pre>[<br>  "DigitalSignature",<br>  "KeyAgreement",<br>  "KeyEncipherment"<br>]</pre> | no |
| vault\_pki\_role\_organization | The pki role organization name | `list(string)` | <pre>[<br>  "my organization"<br>]</pre> | no |
| vault\_pki\_secret\_backend\_path | The PKI secret backend mount path | `string` | `"pki"` | no |
| vault\_ssh\_secret\_backend\_path | The SSH secret backend mount path | `string` | `"ssh-client-signer"` | no |
| vault\_token\_policies | A list of existing token polciies associated to the vault role | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| pki\_secret\_backend\_role\_name | n/a |
| role\_id | n/a |
| secret\_id\_response\_wrapping\_path | n/a |
| ssh\_secret\_backend\_role\_name | n/a |
| wrapping\_accessor | n/a |
| wrapping\_tokens | n/a |

## Usage

The following example creates a vault pki role, ssh signer role, and an approle role with read access to kv v2 path `/secrets/data/foo/bar` and write access to issue certificates on domains `["foo.int", "foo.cloud", "foo.bar"]`.
```
locals {
  name = "vault-approle-example"
}

module "vault_approle" {
  source = "github.com/garyellis/terraform-hashicorp-vault//approle"

  name                           = local.name
  vault_kv_paths                 = ["/secrets/data/foo/bar"]
  vault_pki_role_allowed_domains = ["foo.int", "foo.cloud", "foo.bar"]
}
```
