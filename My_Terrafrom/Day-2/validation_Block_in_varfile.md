variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be one of: dev, stage, or prod."
  }
}

This validation block is used inside a Terraform variable to make sure the user provides only an allowed value.

Let's break it down
-------------------
1. validation
   ------------
validation {

This tells Terraform:

"Before using this variable, check whether its value is valid."

2. condition
condition = contains(["dev", "stage", "prod"], var.environment)

This checks whether the value of var.environment exists in this list:

["dev", "stage", "prod"]

The contains() function works like:

contains(list, value)

For example:

var.environment = "dev"

Terraform checks:

contains(["dev", "stage", "prod"], "dev")

Result:

true

So Terraform accepts it.

But if:

var.environment = "testing"

Terraform checks:

contains(["dev", "stage", "prod"], "testing")

Result:

false

So Terraform rejects it.

3. error_message
error_message = "Environment must be one of: dev, stage, or prod."

If the condition is false, Terraform displays this message:

Error: Invalid value for variable

Environment must be one of: dev, stage, or prod.
Simple flow
terraform.tfvars
      ↓
environment = "dev"
      ↓
validation condition
      ↓
Is "dev" in ["dev", "stage", "prod"]?
      ↓
     YES
      ↓
Terraform continues

If you provide:

environment = "uat"

then:

"uat" → not in allowed list → ❌ validation fails

In one line:
validation ensures that var.environment can contain only dev, stage, or prod.
