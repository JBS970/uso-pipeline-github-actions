# Iniciamos com o bloco do provider
terraform {
  required_version = ">= 1.5.0"
  # Declaramos os providers obrigatorios
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.72.0"
    }
  }

  # Adicionamos um backend para salvar o state deste codico,podemos escolher onde salvar o state,na aws ou na azure
  # Eu estou salvando na azure,no mesmo storage-account e no mesmo container
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"                # Nome do Resource Group onde está a storage account.      
    storage_account_name = "joaosilvaterraformstate"           # Nome da Storage Account do Azure. 
    container_name       = "remote-state"                      # Nome do container no Blob Storage onde o estado será armazenado.         
    key                  = "pipeline-github/terraform.tfstate" # Caminho ou nome do arquivo que armazenará o state file (terraform.tfstate).
  }
}
# Definimos o provider,na aws a regiao é obrigatoria,as tags são opcionais
provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      owner      = "joaosilva"
      managed-by = "terraform"
    }
  }
}
# Definimos o provider ,na azure apenas o bloco feature é obrigatorio,não temos opcao de tags
provider "azurerm" {
  features {}

  skip_provider_registration = true
}

# Declaramos o bloco data-source remote state (aws),para acessar as informacoes do state que criou as estruturas de network da aws
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "joaosilva-remote-state"    # O nome do bucket já criado na aws
    key    = "aws-vpc/terraform.tfstate" # representa a estrutura de diretorios e nome do arquivo que vai ser criado para salvar o state
    region = "eu-central-1"
  }
}

# Declaramos o bloco data-source remote state (azure),para acessar as informacoes do state que criou as estruturas de network
data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-state"           # Nome do Resource Group onde está a storage account.      
    storage_account_name = "joaosilvaterraformstate"      # Nome da Storage Account do Azure. 
    container_name       = "remote-state"                 # Nome do container no Blob Storage onde o estado será armazenado.         
    key                  = "azure-vnet/terraform.tfstate" # Caminho ou nome do arquivo que armazenará o state file (terraform.tfstate).
  }
}
