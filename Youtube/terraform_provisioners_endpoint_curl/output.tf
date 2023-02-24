output "Public-IPs" {
  value = join(",", 
    aws_instance.webserver_pool1.*.public_ip,
    aws_instance.webserver_pool2.*.public_ip
  )
}
