## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| Policy | The policy in json | `any` | `""` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| groups | enable MFA for the members in these groups | `list(string)` | `[]` | no |
| label\_order | label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| name | Name  (e.g. `test` or `mfa`). | `string` | n/a | yes |
| path | The path of the policy in MFA. | `string` | `"/"` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-mfa"` | no |
| users | enable MFA for these users | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam-arn | The ARN assigned by AWS to this policy. |
| tags\_all | Additional tags e.g. map(`BusinessUnit`,`XYZ`) |
