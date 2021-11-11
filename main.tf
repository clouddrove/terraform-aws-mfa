
#Module      : Labels
#Description : Terraform module to create consistent naming for multiple names.
module "labels" {
  source      = "clouddrove/labels/aws"
  version     = "0.15.0"
  name        = var.name
  environment = var.environment
  attributes  = var.attributes
  repository  = var.repository
  managedby   = var.managedby
  label_order = var.label_order

}


resource "aws_iam_policy" "enable_mfa" {
  name        = var.name
  path        = var.path
  description = "Policy to enable MFA "
  policy      = var.Policy
  tags = merge(
    module.labels.tags,
    {
      "Name" = module.labels.id
    }
  )
}


resource "aws_iam_group_policy_attachment" "assign_force_mfa_policy_to_groups" {
  count      = length(var.groups)
  group      = element(var.groups, count.index)
  policy_arn = aws_iam_policy.enable_mfa.arn
}

resource "aws_iam_user_policy_attachment" "assign_force_mfa_policy_to_users" {
  count      = length(var.users)
  user       = element(var.users, count.index)
  policy_arn = aws_iam_policy.enable_mfa.arn
}
