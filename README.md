
# CI/CD Pipelines

<strong><font color="#807a6b"> Azure Devops </font></strong>
- [Build: maven x java (frontend)](/AzureDevops/azdevops_build_maven_java_backend.yml)
- [Build: npm x react (frontend)](/AzureDevops/azdevops_build_npm_react_frontend.yml)
- [Build: yarn x angular (frontend)](/AzureDevops/azdevops_build_yarn_angular_frontend.yml)
- [Build: yarn x vue (frontend)](/AzureDevops/azdevops_build_yarn_vue_frontend.yml)


<strong><font color="#807a6b"> Code Pipelines </font></strong>
- [Build: npm (backend on ec2)](/CodePipelines/codepipelines_build_npm_backend_ec2_buildspec.yml)
- [Build: npm (frontend on s3)](/CodePipelines/codepipelines_build_npm_frontend_s3_buildspec.yml)
- [Deploy: npm (backend on ec2)](/CodePipelines/codepipelines_deploy_ec2_appspec_scripts/codepipelines_deploy_npm_backend_ec2_appspec.yml)

---
# Infrastructure Automation

<strong><font color="#807a6b"> Useful Devops Shellscripts</font></strong>
- [CodeDeploy: Installs Node and CodeDeploy Agent](/UsefulDevopsShellScripts/ec2_userdata_codedeploy_interpreter.sh)
- [Azure Devops: Install and setup AzureDevops Agent](/UsefulDevopsShellScripts/azuredevops_agent_setup.sh)
- [Azure Devops: Update AzureDevops' Public IPs to Firewall Rules](/UsefulDevopsShellScripts/azuredevops_public_ips_grabber.sh)
   - [This files update every Wednestay](https://github.com/pedrosaxu/devops-templates/tree/main/UsefulDevopsShellScripts/azuredevops_public_ips)
- [Kubernetes: Deploy - rollout restart - and watch pods' status](/UsefulDevopsShellScripts/kubernetes_deployment_watcher.sh)


---

# <img src=".github/images/youtube.png" alt="youtube" width="20"> Youtube Videos 
- [\[AZURE DEVOPS\] Agente Self-Hosted com Terraform](https://www.youtube.com/watch?v=amzxuVjOqjk) -> (/Youtube/azdevops_linux_agent)
- [\[SCRIPTS\] Devops, IAC e a Automação "de Antigamente"](https://www.youtube.com/watch?v=U07iWPk8PdY) -> (/Youtube/serie_iac/01_scripts_sob_demanda)
- [\[TERRAFORM\] Terraform Import, Terracognita e Azure Terrafy](https://www.youtube.com/watch?v=DaYPrIk2l0c) -> (/Youtube/terraform_import_terracognita_terrafy)
- [\[TERRAFORM\] Executando scripts com os Terraform Provisioners](https://www.youtube.com/watch?v=3GdaA4Lthag) -> (/Youtube/terraform_provisioners_endpoint_curl)
- [\[TERRAFORM\] Criando Outputs Customizados com External Datasources](https://www.youtube.com/watch?v=ssVp6WzAyTE) -> (/Youtube/terraform_external_data_endpoint_curl)
- [\[AWS\] Autoscaling do ECS Fargate baseado em SQS com Lambda](https://www.youtube.com/watch?v=id) -> (/Youtube/sqs_lambda_ecs_fargate_autoscaling)