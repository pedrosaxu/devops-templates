terraform {
  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = ""
    # }

    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = ""
    # }

  }

  # Não altere o bloco "cloud", ele é preenchido automaticamente com os valores dos ambientes 
  # criados pela pipe no Terraform Cloud, qualquer alteração pode causar erros ou inconsistências no state.
  cloud {
      organization = "pedrosaxu"
      workspaces {
        name = "${client_name}-${account_name}-${env}"
    }
  }
  # Não altere o bloco "cloud", ele é preenchido automaticamente com os valores dos ambientes 
  # criados pela pipe no Terraform Cloud, qualquer alteração pode causar erros ou inconsistências no state.
  
}

# provider "aws" {
# }

# provider "azurerm" {
#   features {}
# }
