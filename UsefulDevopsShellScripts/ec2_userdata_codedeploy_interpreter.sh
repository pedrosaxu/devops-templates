#! /bin/bash

# Atualizando o sistema.
sudo yum update -y

# Instalando o agente do Code Deploy
# Atualizar a variável abaixo conforme a região em que a EC2 está sendo provisionada, a lista está disponível em: 
# https://docs.aws.amazon.com/codedeploy/latest/userguide/resource-kit.html#resource-kit-bucket-names
region="us-east-2"

sudo yum install ruby -y
sudo yum install wget -y
cd /home/ec2-user
wget https://aws-codedeploy-$region.s3.$region.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start

# Instalando interpretador da aplicação, preencha a variávei abaixo conforme a linguagem. 
# Opções disponíveis:
#    - node_16
interpreter="node_16"

case $interpreter in 
    "node_16")
        curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
        sudo yum install nodejs -y
    ;;
esac
