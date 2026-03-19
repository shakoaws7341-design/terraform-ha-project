resource "aws_db_subnet_group" "db_subnet" {
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
}

resource "aws_db_instance" "db" {
  engine         = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  username = "admin"
  password = "StrongPass@1234"

  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true
}
