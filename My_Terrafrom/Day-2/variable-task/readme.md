🟢 Task 1 — Input Variables: EC2 Configuration
--------------------------------------------------
Create a Terraform configuration that launches an EC2 instance.

You must not hardcode these values:

AMI ID
Instance type
Environment
Instance name

Create:

variables.tf
main.tf
terraform.tfvars
outputs.tf

Input variables:

ami_id
instance_type
environment
instance_name

Example terraform.tfvars:

ami_id        = "ami-xxxxxxxx"
instance_type = "t3.micro"
environment   = "dev"
instance_name = "web-server"

Task: Use these variables in main.tf.

🟢 Task 2 — Variable Validation
----------------------------------
Modify Task 1 so that environment accepts only:

dev
stage
prod

If someone provides:

environment = "testing"

Terraform should fail during validation.

Requirement: Use a Terraform validation block.

🟢 Task 3 — Variable Defaults
-------------------------------
Create variables:

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

Now run Terraform without specifying instance_type.

Understand:

Variable value supplied?
        |
     YES → use supplied value
        |
     NO
        |
     default → use default value

Then override it using:

terraform apply -var="instance_type=t3.small"

🟡 Task 4 — Local Variables
----------------------------
Create locals for common naming and tags.

Input:

environment = "prod"
project     = "ecommerce"

Create:

locals {
  name_prefix = "${var.project}-${var.environment}"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

Use local.name_prefix and local.common_tags for your resources.

Goal: Understand the difference:

var.xxx
   ↓
User provides the value

local.xxx
   ↓
Terraform calculates/organizes the value internally


🟡 Task 5 — Output Variables
-----------------------------
Create an EC2 instance and output:

instance_id
instance_private_ip
instance_public_ip
instance_name

Example:

output "instance_id" {
  value = aws_instance.web.id
}

Run:

terraform apply

Then:

terraform output

🟡 Task 6 — Output Sensitive Information
------------------------------------------
Create a variable:

variable "database_password" {
  type      = string
  sensitive = true
}

Create an output:

output "database_password" {
  value     = var.database_password
  sensitive = true
}

Run:

terraform output

Understand why Terraform hides the value.

Interview question:

Does sensitive = true encrypt the secret in the Terraform state file?

You need to answer this.

🔴 Task 7 — Combine Variables + Locals + Outputs
----------------------------------------------------------
Create a VPC using:

Input variables
project_name
environment
vpc_cidr
availability_zones

For example:

project_name       = "ecommerce"
environment        = "prod"
vpc_cidr           = "10.0.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]
Locals

Create:

VPC name
common tags
environment-specific naming

Example:

ecommerce-prod-vpc
ecommerce-prod-subnet
Outputs

Return:

vpc_id
vpc_cidr
availability_zones

🔴 Task 8 — Environment-Specific Configuration
-------------------------------------------------
Create:

dev.tfvars
stage.tfvars
prod.tfvars

Example:

dev.tfvars
environment  = "dev"
instance_type = "t3.micro"
prod.tfvars
environment  = "prod"
instance_type = "t3.large"

Deploy using:

terraform apply -var-file="dev.tfvars"

and:

terraform apply -var-file="prod.tfvars"

Understand how the same Terraform code can create different environments.

🔥 Task 9 — Real Interview Scenario
-----------------------------------------
Your Terraform code currently has:

resource "aws_instance" "web" {
  instance_type = "t3.micro"

  tags = {
    Name = "prod-web"
  }
}

Your manager says:

"We have 10 environments. Don't hardcode environment names, instance types, or tags in the Terraform resources."

Refactor the code using:

Input Variables
       ↓
     Locals
       ↓
    Resources
       ↓
     Outputs

Your final design should allow:

terraform apply -var-file="dev.tfvars"
terraform apply -var-file="stage.tfvars"
terraform apply -var-file="prod.tfvars"

without changing main.tf.
