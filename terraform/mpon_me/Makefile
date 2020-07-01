init:
	terraform init \
		-backend-config="bucket=${TF_BACKEND_CONFIG_BUCKET}"
plan:
	terraform fmt -diff && terraform plan
apply:
	terraform fmt -diff && terraform apply
destroy:
	terraform destroy