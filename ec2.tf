# Launch EC2 server

resource "aws_instance" "food-server" {
  ami           = "ami-0763cf792771fe1bd"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.food-subnet.id
  security_groups = [aws_security_group.ssh-http-sg.id]
  user_data = file ("food.sh")

  tags = {
    Name = "FOOD"
  }
}

