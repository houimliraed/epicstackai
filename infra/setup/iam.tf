########################################
# IAM User for Deployment
########################################

resource "aws_iam_user" "cd" {
  name = "saas-pme-cd"
}

resource "aws_iam_access_key" "cd" {
  user = aws_iam_user.cd.name
}

########################################
# Terraform Backend Access (S3)
########################################

data "aws_iam_policy_document" "backend_s3" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.tf-state-bucket}"]
  }
  statement {
    effect  = "Allow"
    actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = [
      "arn:aws:s3:::${var.tf-state-bucket}/*"
    ]
  }
}

resource "aws_iam_policy" "tf_backend" {
  name        = "${aws_iam_user.cd.id}-tf-s3"
  description = "Allow CD user to access S3 for Terraform backend"
  policy      = data.aws_iam_policy_document.backend_s3.json
}

resource "aws_iam_user_policy_attachment" "tf_backend" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.tf_backend.arn
}

########################################
# ECR Permissions
########################################

data "aws_iam_policy_document" "ecr" {
  statement {
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
  statement {
    effect  = "Allow"
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:DescribeRepositories",
      "ecr:ListImages"
    ]
    resources = [
      aws_ecr_repository.front.arn,
      aws_ecr_repository.back.arn,
    ]
  }
}

resource "aws_iam_policy" "ecr" {
  name        = "${aws_iam_user.cd.name}-ecr"
  description = "Allow user to manage ECR resources"
  policy      = data.aws_iam_policy_document.ecr.json
}

resource "aws_iam_user_policy_attachment" "ecr" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.ecr.arn
}

########################################
# S3 & CloudFront Permissions
########################################

data "aws_iam_policy_document" "s3_cloudfront" {
  statement {
    effect = "Allow"
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "cloudfront:CreateDistribution",
      "cloudfront:UpdateDistribution",
      "cloudfront:GetDistribution",
      "cloudfront:ListDistributions",
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "s3_cloudfront" {
  name        = "${aws_iam_user.cd.name}-s3-cloudfront"
  description = "Allow S3 and CloudFront management"
  policy      = data.aws_iam_policy_document.s3_cloudfront.json
}

resource "aws_iam_user_policy_attachment" "s3_cloudfront" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.s3_cloudfront.arn
}

########################################
# EC2 Permissions
########################################

data "aws_iam_policy_document" "ec2" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2" {
  name        = "${aws_iam_user.cd.name}-ec2"
  description = "Allow user to manage EC2 resources"
  policy      = data.aws_iam_policy_document.ec2.json
}

resource "aws_iam_user_policy_attachment" "ec2" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.ec2.arn
}

########################################
# RDS Permissions
########################################

data "aws_iam_policy_document" "rds" {
  statement {
    effect = "Allow"
    actions = [
      "rds:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "rds" {
  name        = "${aws_iam_user.cd.name}-rds"
  description = "Allow user to manage RDS resources"
  policy      = data.aws_iam_policy_document.rds.json
}

resource "aws_iam_user_policy_attachment" "rds" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.rds.arn
}

########################################
# ECS Permissions
########################################

data "aws_iam_policy_document" "ecs" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecs" {
  name        = "${aws_iam_user.cd.name}-ecs"
  description = "Allow user to manage ECS resources"
  policy      = data.aws_iam_policy_document.ecs.json
}

resource "aws_iam_user_policy_attachment" "ecs" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.ecs.arn
}

########################################
# IAM Permissions
########################################

data "aws_iam_policy_document" "iam" {
  statement {
    effect = "Allow"
    actions = [
      "iam:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam" {
  name        = "${aws_iam_user.cd.name}-iam"
  description = "Allow user to manage IAM resources"
  policy      = data.aws_iam_policy_document.iam.json
}

resource "aws_iam_user_policy_attachment" "iam" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.iam.arn
}

########################################
# CloudWatch Permissions
########################################

data "aws_iam_policy_document" "logs" {
  statement {
    effect = "Allow"
    actions = [
      "logs:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "logs" {
  name        = "${aws_iam_user.cd.name}-logs"
  description = "Allow user to manage CloudWatch"
  policy      = data.aws_iam_policy_document.logs.json
}

resource "aws_iam_user_policy_attachment" "logs" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.logs.arn
}
