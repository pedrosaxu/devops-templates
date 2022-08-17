# devops-templates
Repository where I'll save and publish all the templates I develop on my day-to-day basis.

---

## CI/CD Pipelines

###<font color="#807a6b"> Azure Devops </font>
- [Build: maven x java (frontend)](/devops-templates/AzureDevops/azdevops_build_maven_java_backend.yml)
- [Build: npm x react (frontend)](/devops-templates/AzureDevops/azdevops_build_npm_react_frontend.yml)
- [Build: yarn x angular (frontend)](/devops-templates/AzureDevops/azdevops_build_yarn_angular_frontend.yml)
- [Build: yarn x vue (frontend)](/devops-templates/AzureDevops/azdevops_build_yarn_vue_frontend.yml)


###<font color="#807a6b"> Code Pipelines </font>
- [Build: npm (backend on ec2)](/devops-templates/CodePipelines/codepipelines_build_npm_backend_ec2_buildspec.yml)
- [Build: npm (frontend on s3)](/devops-templates/CodePipelines/codepipelines_build_npm_frontend_s3_buildspec.yml)
- [Deploy: npm (backend on ec2)](/devops-templates/CodePipelines/codepipelines_deploy_ec2_appspec_scripts/codepipelines_deploy_npm_backend_ec2_appspec.yml)

---
## Infrastructure Automation

###<font color="#807a6b"> Bootstrap Scripts </font>
- [Build: npm (backend on ec2).yml](/devops-templates/BootstrapScripts/ec2_userdata_codedeploy_interpreter.sh)