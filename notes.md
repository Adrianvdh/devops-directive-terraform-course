
# Terraform

## AWS CLI
```bash
$ aws configure
```

## AWS Terraform init

```bash
# Initalises the project
terraform init
# Takes your configuration, checks it against the currently deployed state of
# the world and figures out the steps to provision infrastructure
terraform plan
# Takes those commands and applies them
terraform apply
# Cleans up resources
terraform destroy
```


## Resource
The general syntax for a Terraform resource is:

```terraform
resource "<PROVIDER>_<TYPE>" "<NAME>" {
 [CONFIG …]
}
```

## Variables
Define input variables. The syntax for declaring a variable is:

```terraform
variable "NAME" {
 [CONFIG ...]
}
```
