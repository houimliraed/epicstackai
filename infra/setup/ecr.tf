
# ecr repo for storing the docker images

resource "aws_ecr_repository" "front" {
  name                 = "epicstack_front"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "back" {
  name                 = "epicstack_back"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = false
  }
}
