#########################
# RDS Subnet Group
#########################
resource "aws_db_subnet_group" "main" {
  name       = "${var.prefix}-main"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "${var.prefix}-db-subnet-group"
  }
}

#########################
# RDS Security Group
#########################
resource "aws_security_group" "rds" {
  name        = "${var.prefix}-rds-inbound-access"
  description = "Allow access to RDS instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-rds-security-group"
  }
}

#########################
# RDS Instance
#########################
resource "aws_db_instance" "main" {
  identifier                 = "${local.prefix}-db"
  db_name                    = "recipe"
  allocated_storage          = 20
  storage_type               = "gp2"
  engine                     = "postgres"
  engine_version             = "15.10"
  instance_class             = "db.t4g.micro"
  username                   = var.db_username
  password                   = var.db_password
  skip_final_snapshot        = true
  multi_az                   = false
  backup_retention_period    = 0

  db_subnet_group_name       = aws_db_subnet_group.main.name
  vpc_security_group_ids     = [aws_security_group.rds.id]

  tags = {
    Name = "${local.prefix}-main"
  }
}
