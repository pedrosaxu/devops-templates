#!/bin/bash

# Declare variables
AZ_AGENT_USER="ec2-user"
AZ_ORGANIZATION_NAME="test-julia"
AZ_ORGANIZATION_PAT="<token>"
AZ_AGENT_POOL_NAME="linux-ubuntu"

# Download and unpack the agent
cd ~
mkdir azdevops_agent && cd azdevops_agent
wget https://vstsagentpackage.azureedge.net/agent/2.190.0/vsts-agent-linux-x64-2.190.0.tar.gz # Updated on 2023-16-01
tar zxvf vsts-agent-linux-*.tar.gz
rm -rf vsts-agent-linux-*.tar.gz

# Setup/sign agent on organization
./config.sh --unattended --url https://dev.azure.com/$AZ_ORGANIZATION_NAME --auth pat --token $AZ_ORGANIZATION_PAT --pool $AZ_AGENT_POOL_NAME --replace --acceptTeeEula 

# Install as a service
sudo ./svc.sh install $AZ_AGENT_USER

# Start the service
sudo ./svc.sh start

# Check the service status
sudo ./svc.sh status
