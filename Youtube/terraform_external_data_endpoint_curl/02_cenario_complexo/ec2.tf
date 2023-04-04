resource "aws_key_pair" "webserver-key" {
  key_name   = "webserver-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "webserver_pool1" {
  count                       = 2
  ami                         = data.aws_ssm_parameter.webserver-ami.value
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.webserver-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id
  user_data = <<EOF
#!/bin/bash
yum -y install httpd && systemctl start httpd
echo '<h1><center>Pool 1: Webserver ${count.index}</center></h1>' > index.html
mv index.html /var/www/html/
EOF

  tags = {
    Name = "webserver"
  }
}

