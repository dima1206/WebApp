This file describes how to use the code in this repository. Make sure to check out the [SETUP.md](./SETUP.md) guide first to install and configure tools that are used in this guide.

Clone the repository:

```
git clone -b jenkins-setup/main https://github.com/dima1206/WebApp.git WebApp-jenkins-setup
```

Go to the Terraform folder:

```
cd WebApp-jenkins-setup/terraform
```

TODO: finish this guide

Configure:
terraform variables
ansible variables
ansible vault
region (terraform variables and ansible dynamic inventory)

Initialize terraform:

```
terraform init
```

terraform plan -var-file="my.tfvars"
terraform apply -var-file="my.tfvars"

TODO: destroy whatever was created from Jenkins first

terraform destroy -var-file="my.tfvars"
