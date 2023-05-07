Warning about manually switching environments
```
terraform workspace new production
terraform workspace list
terraform workspace select production
terraform workspace select staging
terraform destroy -lock=false
```