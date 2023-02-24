resource "aws_key_pair" "webserver-key" {
  key_name   = "webserver-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


## Remote-exec & Local Exec ##

resource "aws_instance" "webserver_pool1" {
  count                       = 4
  ami                         = data.aws_ssm_parameter.webserver-ami.value
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.webserver-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd && sudo systemctl start httpd",
      "echo '<h1><center>Pool 1: Webserver ${count.index}</center></h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
  
  provisioner "local-exec" {
     command = "echo \"${self.public_ip}: `curl ${self.public_ip}`\" >> test_webserver_pool1.txt"
   }
 
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf test_webserver_pool1.txt"
  }
  
  tags = {
    Name = "webserver"
  }
}


### Custom Data + Null Resource ###

resource "aws_instance" "webserver_pool2" {
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
echo '<h1><center>Pool 3: Webserver ${count.index}</center></h1>' > index.html
mv index.html /var/www/html/
EOF
  tags = {
    Name = "webserver"
  }
}

# resource "null_resource" "script" {
#   # Força a recriação/execução do provisioner a cada execução do terraform
#   triggers = { uuid = uuid() }
  
#   for_each = toset(aws_instance.webserver_pool2.*.public_ip)

#   provisioner "local-exec" {
#       # Run on resource creation
#       command = "echo \"\" > test_webserver_pool2.txt && echo \"${each.value}: `curl ${each.value}`\" >> test_webserver_pool2.txt"
#    }

#   depends_on = [aws_instance.webserver_pool2]
# }





