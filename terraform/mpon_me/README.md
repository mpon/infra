# mpon_me

Management `mpon.me`

## How to apply

### Setup

```bash
export export TF_BACKEND_CONFIG_BUCKET="___your_infra_bucket____"
brew install tfenv
cd terraform/mpon_me
tfenv install
make init
```

### Plan & Apply

```bash
cd terraform/mpon_me
make plan
make apply
```
