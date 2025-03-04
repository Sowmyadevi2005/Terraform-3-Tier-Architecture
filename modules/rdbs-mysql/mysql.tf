# Subnet group for RDS database
resource "aws_db_subnet_group" "db_subnet" {
# Defining an AWS resource
  name       = var.db_subnet_gp_name
  subnet_ids = var.db_subnets

  tags = {
    Name = "3-tier-db subnet"
  }
}



# Fetch database password from AWS Secrets Manager
data "aws_secretsmanager_secret" "db_password" {
# Fetching existing data from AWS
  name = "mydb-password"
}

data "aws_secretsmanager_secret_version" "db_password_version" {
# Fetching existing data from AWS
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

# Create the RDS MySQL database instance
resource "aws_db_instance" "mysql" {
# Defining an AWS resource
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  identifier           = var.db_identifier
  username             = "admin"
  password             = data.aws_secretsmanager_secret_version.db_password_version.secret_string
# Fetching existing data from AWS
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags = {
    Name = var.db_name
  }
}