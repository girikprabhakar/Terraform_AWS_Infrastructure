resource "aws_instance" "instance_1" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.instances.name]
  tags = {
    "Name" = var.instance_name
  }
  user_data = <<-EOF
                #!/bin/bash
                echo "Hello World 1" > index.html
                python3 -m http.server 8080 &
                EOF
}
