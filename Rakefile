@terraform_image = "hashicorp/terraform:0.11.2"

def docker(dir)
  %Q(docker run -it -v "$(pwd):/work" -w /work/#{dir} \
    -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
    -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" #{@terraform_image})
end

def create_terraform_task(env)

  dir = "terraform/#{env}"

  namespace :tf do
    desc "terraform init for #{env}"
    task :init do
      abort "you need to set TF_BACKEND_BUCKET" unless ENV["TF_BACKEND_BUCKET"]
      sh %Q(touch "#{dir}/terraform.tfvars")
      puts "create #{dir}/terraform.tfvars you need to fill variables"
      sh %Q(#{docker(dir)} get)
      sh %Q(#{docker(dir)} init \
            -backend-config "bucket=#{ENV["TF_BACKEND_BUCKET"]}" \
            -backend-config "key=#{env}/terraform.tfstate")
    end

    desc "terraform plan for #{env}"
    task :plan do
      sh %Q(#{docker(dir)} fmt -diff=true ..)
      sh %Q(#{docker(dir)} get)
      sh %Q(#{docker(dir)} plan)
    end

    desc "terraform apply for #{env}"
    task :apply do
      sh %Q(#{docker(dir)} apply)
    end

    desc "terraform destroy for #{env}"
    task :destroy do
      sh %Q(#{docker(dir)} destroy)
    end
  end
end

namespace :sandbox do
  create_terraform_task("sandbox")
end
