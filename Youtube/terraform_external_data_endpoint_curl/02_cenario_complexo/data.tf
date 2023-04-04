#Get Linux AMI ID using SSM Parameter endpoint in us-east-1
data "aws_ssm_parameter" "webserver-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#Get main route table to modify
data "aws_route_table" "main_route_table" {
  filter {
    name   = "association.main"
    values = ["true"]
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.vpc.id]
  }
}

#Get all available AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  state = "available"
}


# Get script ovewriting variables
data "external" "curl_tests" {
  for_each = { for k, v in aws_instance.webserver_pool1 : k => v.public_ip }
  program = ["bash", "${path.root}/endpoint_curl.sh"]
  query = {
    ip = each.value
  }
}

