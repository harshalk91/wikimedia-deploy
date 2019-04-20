resource "aws_instance" "my-test-instance" {
  ami             = "${var.ami}" 
  instance_type   = "${var.instance_type}"
  vpc_security_group_ids  = "${var.vpc_security_group_ids}"
  subnet_id	  = "${var.subnet_id}"
  key_name 	  = "${var.key_name}"
  associate_public_ip_address = true
  user_data = "${file("user-data.txt")}"

  tags {
    Name = "demo-tw-assignment"
  }
}

