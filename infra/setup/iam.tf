

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
      "ecr:PutImage"
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
