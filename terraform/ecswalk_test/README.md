# ecswalk_test

Test Environment for [ecswalk](https://github.com/mpon/ecswalk)

This is **Not Production VPC And ECS** settings.

## How to apply

### Setup

```bash
brew install tfenv
cd terraform/ecswalk_test
tfenv install
terraform init
```

### Plan & Apply

```bash
cd terraform/ecswalk_test
terraform fmt
terraform plan
terfaform apply
```
