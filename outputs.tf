output "iam-arn" {
  value = aws_iam_policy.enable_mfa.arn

}

output "tags_all" {
  value = aws_iam_policy.enable_mfa.tags_all

}