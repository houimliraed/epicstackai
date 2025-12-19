output "cd_user_access_key_id" {
  description = "AWS ACCESS KEY ID FOR CD USER"
  value       = aws_iam_access_key.cd.id
}

output "cd_user_access_key_secret" {
  description = "Access key secret for cd user"
  value       = aws_iam_access_key.cd.secret
  sensitive   = true
}

output "ecr_repo_front" {
  description = "ECR repository URL for the frontend image"
  value       = aws_ecr_repository.front.repository_url
}

output "ecr_repo_back" {
  description = "ECR repository URL for the backend image"
  value       = aws_ecr_repository.back.repository_url
}