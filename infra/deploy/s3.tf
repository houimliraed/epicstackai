

resource "aws_s3_bucket" "epicstack_front" {
    bucket = "epicstack-front"

    tags = {
    Name = "${local.prefix}-epicstack-front"
    }
}