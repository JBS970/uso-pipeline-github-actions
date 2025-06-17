# uso-pipeline-github-actions
Teremos 3 wokflows separados,3 arquivos de configuração diferentes ,para criar VMs na Aws e Azure


copia-
name: Terraform Plan
on: push
env: 
  AWS_ACCESS_KEY: ${{secrets.AWS_ACCESS_KEY}}
  AWS_SECRET_ACCESS_KEY: ${{secrets.AWS_SECRET_ACCESS_KEY}}
  ARM_CLIENT_ID: ${{secrets.ARM_CLIENT_ID}}
  ARM_CLIENT_SECRET: ${{secrets.ARM_CLIENT_SECRET}}
  ARM_SUBSCRIPTION_ID: ${{secrets.ARM_SUBSCRIPTION_ID}}
  ARM_TENANT_ID: ${{secrets.ARM_TENANT_ID}}
  TF_VAR_aws_key_pub: ${{secrets.TF_VAR_aws_key_pub}}
  TF_VAR_azure_key_pub: ${{secrets.TF_VAR_azure_key_pub}}

jobs:
  terraform_plan:
    name: Terraform Plan
    runs-on: ubuntu-latest
    defaults:
      run:
        shell: bash
    steps:
    - name: Checkout
      uses: actions/checkout@v4
    - name: Terraform Plan
      run: |
          terraform init
          terraform validate
          terraform plan
----------------------------------------------------------------------------
name: Terraform Plan
on: push
env: 
  AWS_ACCESS_KEY: ${{secrets.AWS_ACCESS_KEY}}
  AWS_SECRET_ACCESS_KEY: ${{secrets.AWS_SECRET_ACCESS_KEY}}
  ARM_CLIENT_ID: ${{secrets.ARM_CLIENT_ID}}
  ARM_CLIENT_SECRET: ${{secrets.ARM_CLIENT_SECRET}}
  ARM_SUBSCRIPTION_ID: ${{secrets.ARM_SUBSCRIPTION_ID}}
  ARM_TENANT_ID: ${{secrets.ARM_TENANT_ID}}
  TF_VAR_aws_key_pub: ${{secrets.TF_VAR_aws_key_pub}}
  TF_VAR_azure_key_pub: ${{secrets.TF_VAR_azure_key_pub}}

jobs:
  terraform_plan:
    name: Terraform Plan
    runs-on: ubuntu-latest
    defaults:
      run:
        shell: bash
    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Install Terraform
      run: |
          sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
          curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
          echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
          sudo apt-get update && sudo apt-get install terraform

    - name: Terraform Plan
      run: |
          terraform init
          terraform validate
          terraform plan          
