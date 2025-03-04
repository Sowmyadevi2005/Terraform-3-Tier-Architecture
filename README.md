****3-Tier Architecture on AWS using Terraform****

**Project Overview**
This project implements a 3-Tier Architecture on AWS using Terraform Infrastructure as Code (IaC). The architecture is designed to provide a highly modular, scalable, and secure environment across Development and Staging environments.

**Key Features**

•	Infrastructure as Code: Automates infrastructure provisioning using Terraform.

•	Modular Design: VPC, Compute, Security Groups, Database, and Load Balancer are separated into reusable modules.

•	Cost Optimization: Automated cleanup scripts for unused AWS resources like EC2, EBS volumes, Elastic IPs, and NAT Gateways.

•	Secrets Management: AWS Secrets Manager is used to store sensitive data.

•	Remote State Management: S3 bucket with DynamoDB for state locking and versioning.

•	Multiple Environments: Dev and Staging environments managed through Terraform Workspaces and tfvars files.

________________________________________
**Project Structure**

3-tier architecture/

├── root/

│   ├── backend.tf            # Backend Configuration (S3 + DynamoDB)

│   ├── dev.tfvars           # Variables for Dev Environment

│   ├── stg.tfvars           # Variables for Staging Environment

│   ├── main.tf              # Root module that calls child modules

│   ├── variable.tf          # Global Variables

│   └── user-data.sh         # EC2 User Data Script

│

└── modules/

    ├── vpc                 # VPC Module
    
    ├── auto_scaling        # Auto Scaling Group Module
    
    ├── security_groups     # Security Groups Module
    
    ├── load-balancer       # Application Load Balancer Module
    
    └── rdbs-mysql          # RDS MySQL Module
    
________________________________________
**Prerequisites**

•	Terraform v1.5+

•	AWS CLI configured with appropriate IAM permissions

•	Git
________________________________________
**How to Deploy**

1. Clone the Repository

    git clone [GitHub Repo Link]

    cd 3-tier architecture

2. Initialize Terraform

    terraform init

3. Select Environment Workspace

    terraform workspace new dev    # For Dev Environment

    terraform workspace select dev

4. Plan and Apply
    terraform plan -var-file="dev.tfvars"

    terraform apply -var-file="dev.tfvars"

5. Destroy Infrastructure

    terraform destroy -var-file="dev.tfvars"
________________________________________
**Remote Backend Configuration**

Terraform remote state is stored in S3 with DynamoDB locking. Configure backend.tf with your bucket name:

backend "s3" {

  bucket         = "your-s3-bucket-name"
  
  key            = "terraform.tfstate"
  
  region         = "ap-south-1"
  
  encrypt        = true
  
}
________________________________________
**Secrets Management**

Sensitive information like database passwords is stored securely in AWS Secrets Manager. The secret is fetched dynamically during resource provisioning.
________________________________________
**Cleanup Automation**

Scripts automatically clean up unused AWS resources like:

•	Unattached EBS Volumes

•	Unused Elastic IPs

•	Idle NAT Gateways
________________________________________

