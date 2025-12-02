# 📘 Strapi CMS Deployment on AWS Using Terraform

This project demonstrates how to deploy a **Strapi Headless CMS** on **AWS EC2** using **Terraform Infrastructure as Code (IaC)**.

## 🚀 Project Overview
- Full Strapi CMS application
- Terraform provisioning for EC2, Security Group, Key Pair, and more
- Cloud deployment of Strapi in production mode

## 📂 Project Structure
```
my-strapi-aws-terraform/
├── strapi-app/
└── infra/
    ├── provider.tf
    ├── variables.tf
    ├── main.tf
    ├── outputs.tf
```

## 🛠️ Technologies Used
- Strapi v5
- Node.js v18+
- Terraform v1.5+
- AWS EC2 (Amazon Linux 2023)
- GitHub & VS Code

## ⚙️ Terraform Deployment
```
terraform init
terraform plan
terraform apply
```

## 🔐 SSH Access
```
ssh -i "path_to_id_rsa" ec2-user@<public_ip>
```

## 📦 Strapi Deployment on EC2
```
cd /opt/my-strapi-aws-terraform
git clone <repo>
cd strapi-app
npm install
NODE_ENV=production npm run build
NODE_ENV=production HOST=0.0.0.0 PORT=1337 npm run start
```

## 🌐 Access Live Strapi
```
http://ec2-<public_dns>.compute.amazonaws.com:1337
```

## 🎥 Screencast Demo
(Add your video link here)

## 🧑‍💻 Author
Judson K.
