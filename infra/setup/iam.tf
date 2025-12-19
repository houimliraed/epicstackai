

# creating the iam user and policies for deployement account

resource "aws_iam_user" "cd" {
  name = "saas-pme-cd"
}

resource "aws_iam_access_key" "cd" {
  user = aws_iam_user.cd.name
}

# policy document for terraform backend access

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
      "arn:aws:s3:::${var.tf-state-bucket}/tf-state-deploy/*",
      "arn:aws:s3:::${var.tf-state-bucket}/tf-state-deploy-env/*"
    ]
  }
}
resource "aws_iam_policy" "tf_backend" {

  name        = "${aws_iam_user.cd.id}-tf-s3"
  description = "Allow cd user to access S3 for terraform backend ressources"
  policy      = data.aws_iam_policy_document.backend_s3.json

}

resource "aws_iam_user_policy_attachment" "tf_backend" {

  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.tf_backend.arn

}

### iam for ecrr

data "aws_iam_policy_document" "ecr" {
  statement {
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
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

#########################
# Policy for EC2 access #
#########################

data "aws_iam_policy_document" "ec2" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeVpcs",
      "ec2:CreateTags",
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:DescribeSecurityGroups",
      "ec2:DeleteSubnet",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DetachInternetGateway",
      "ec2:DescribeInternetGateways",
      "ec2:DeleteInternetGateway",
      "ec2:DetachNetworkInterface",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeRouteTables",
      "ec2:DeleteRouteTable",
      "ec2:DeleteVpcEndpoints",
      "ec2:DisassociateRouteTable",
      "ec2:DeleteRoute",
      "ec2:DescribePrefixLists",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeNetworkAcls",
      "ec2:AssociateRouteTable",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:CreateSecurityGroup",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:CreateVpcEndpoint",
      "ec2:ModifySubnetAttribute",
      "ec2:CreateSubnet",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateInternetGateway",
      "ec2:AttachInternetGateway",
      "ec2:ModifyVpcAttribute",
      "ec2:RevokeSecurityGroupIngress",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2" {
  name        = "${aws_iam_user.cd.name}-ec2"
  description = "Allow user to manage EC2 resources."
  policy      = data.aws_iam_policy_document.ec2.json
}

resource "aws_iam_user_policy_attachment" "ec2" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.ec2.arn
}

#############################
# Policy for S3 + CloudFront
#############################

data "aws_iam_policy_document" "s3_cloudfront" {

  # Allow uploading frontend build to S3
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = [
  var.frontend_bucket_arn,
  "${var.frontend_bucket_arn}/*"
    ]
  }

  # Allow CloudFront cache invalidation on deploy
  statement {
    effect = "Allow"
    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetDistribution",
      "cloudfront:GetDistributionConfig",
      "cloudfront:ListDistributions"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "s3_cloudfront" {
  name        = "${aws_iam_user.cd.name}-s3-cloudfront"
  description = "Allow CD user to deploy frontend: upload to S3 + invalidate CloudFront"
  policy      = data.aws_iam_policy_document.s3_cloudfront.json
}

resource "aws_iam_user_policy_attachment" "s3_cloudfront" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.s3_cloudfront.arn
}
