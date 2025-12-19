
resource "aws_s3_bucket" "epicstack-front" {
    bucket = "${local.prefix}-front"

}