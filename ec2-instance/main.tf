resource "aws_instance" "my-test-instance" {
  ami             = "ami-02e60be79e78fef21" 
  instance_type   = "t2.micro"
  vpc_security_group_ids  = ["sg-01fe62c6f88a2ffa2"]
  subnet_id	  = "subnet-0c59f2b12acdcefd5"
  key_name 	  = "demo_mediawiki"
  associate_public_ip_address = true
  user_data = "${file("../shared/user-data.txt")}"

  tags {
    Name = "test-instance"
  }
}

