
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
- [CodeDeploy: nstalls Node and CodeDeploy Agent](/UsefulDevopsShellScripts/ec2_userdata_codedeploy_interpreter.sh)
- [Azure Devops: Install and setup AzureDevops Agent](/UsefulDevopsShellScripts/azuredevops_agent_setup.sh)
- [Azure Devops: Update AzureDevops' Public IPs to Firewall Rules](/UsefulDevopsShellScripts/azuredevops_public_ips_grabber.sh)
- [Kubernetes: Deploy - rollout restart - and watch pods' status](/UsefulDevopsShellScripts/kubernetes_deployment_watcher.sh)