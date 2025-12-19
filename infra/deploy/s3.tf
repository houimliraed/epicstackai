

resource "aws_s3_bucket" "epicstack_front" {
    bucket = "epicstack-front"

    tags = {
    Name = "${local.prefix}-epicstack-front"
    }
}


module "setup" {
  source = "../setup"
  frontend_bucket_arn = aws_s3_bucket.epicstack_front.arn
}