
# Subnet group for RDS (must use private subnets in 2 AZs)
resource "aws_db_subnet_group" "db_subnets" {
  name       = "${var.project_name}-db-subnets"
  subnet_ids = values(aws_subnet.private)[*].id
  tags = { Name = "${var.project_name}-db-subnets" }
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_db_instance" "db" {
  identifier                 = "${var.project_name}-db"
  engine                     = var.db_engine
  engine_version             = var.db_engine_version
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  db_name                    = var.db_name
  username                   = var.db_username
  password                   = random_password.db_password.result

  db_subnet_group_name       = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids     = [aws_security_group.rds_sg.id]

  multi_az                   = false
  publicly_accessible        = false
  storage_encrypted          = true
  deletion_protection        = false
  skip_final_snapshot        = true

  tags = { Name = "${var.project_name}-rds" }
}
