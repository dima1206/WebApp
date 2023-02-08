This file describes how to use the code in this repository. Make sure to check out the [SETUP.md](./SETUP.md) guide first to install and configure tools that are used in this guide.

Clone the repository:

```
git clone -b jenkins-setup/main https://github.com/dima1206/WebApp.git WebApp-jenkins-setup
```

Go to the Terraform folder:

```
cd WebApp-jenkins-setup/terraform
```

Initialize terraform:

```
terraform init
```

TODO: finish this guide

echo 'my_ip = "0.0.0.0/0"' > my_ip.tfvars
terraform plan -var-file="my_ip.tfvars"
terraform apply -var-file="my_ip.tfvars"

TODO: destroy whatever was created from Jenkins first

terraform destroy
