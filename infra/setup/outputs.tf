output "cd_user_access_key_id" {
  description = "AWS ACCESS KEY ID FOR CD USER"
  value       = aws_iam_user.cd.id

}

output "cd_user_access_key_secret" {
  description = "Access key secret for cd user"
  value       = aws_iam_access_key.cd.secret
  sensitive   = true
}