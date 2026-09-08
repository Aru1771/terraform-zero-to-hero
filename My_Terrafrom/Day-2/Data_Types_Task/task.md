🟢 Day 7 — Terraform Type Constraints Tasks

You will create 7 separate tasks covering all the important Terraform data types.

Task 1 — String

Create a variable for an AWS project name.

Requirements

Create:

project_name

It must:

Be of type string
Have a default value
Be used to create an AWS VPC name using the Name tag

Example expected tag:

Name = "devops-project-vpc"
Challenge

Add a validation rule so that:

Project name must be at least 3 characters
Project name cannot be empty
Task 2 — Number

Create variables for VPC network sizing.

Requirements

Create:

instance_count

It must:

Be of type number
Have a default value of 2
Be used to control how many EC2 instances Terraform creates

Example:

instance_count = 3

Terraform should create:

EC2-1
EC2-2
EC2-3
Challenge

Add validation:

instance_count >= 1
instance_count <= 5
Task 3 — Bool

Create a variable:

enable_monitoring

It must:

Be of type bool
Default to false

Use it to control whether EC2 monitoring is enabled.

For example:

enable_monitoring = true

should enable monitoring.

enable_monitoring = false

should disable it.

Challenge

Use a Terraform conditional expression:

condition ? true_value : false_value
Task 4 — List

Create a variable containing availability zones.

availability_zones

Type:

list(string)

Example:

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c"
]
Requirements

Use this list to create one subnet in each availability zone.

Expected:

ap-south-1a → subnet
ap-south-1b → subnet
ap-south-1c → subnet
Challenge

Use:

for_each

or:

count

to dynamically create the subnets.

Task 5 — Set

Create a variable:

allowed_ports

Type:

set(number)

Example:

allowed_ports = [
  22,
  80,
  443
]

Create security-group ingress rules for these ports.

Expected:

22  → SSH
80  → HTTP
443 → HTTPS
Challenge

Add a duplicate:

allowed_ports = [
  22,
  80,
  443,
  80
]

Observe what happens.

Understand why a set is useful when you want unique values and don't care about ordering.

Task 6 — Map

Create a variable:

environment_tags

Type:

map(string)

Example:

environment_tags = {
  Environment = "dev"
  Owner       = "devops"
  Project     = "terraform"
}

Use this variable as tags on your AWS VPC.

Expected:

Environment = dev
Owner       = devops
Project     = terraform
Challenge

Add another tag without changing the resource itself.

For example:

CostCenter = "1234"

You should only modify the variable value.

Task 7 — Tuple

Create a variable representing an application's configuration:

application_config

Use:

tuple([string, number, bool])

Example:

application_config = [
  "myapp",
  8080,
  true
]

Meaning:

Element 0 → application name → string
Element 1 → application port → number
Element 2 → monitoring enabled → bool

Use the values in your Terraform configuration.

Challenge

Try changing the values to:

application_config = [
  "myapp",
  "8080",
  true
]

Observe the type error.

This will help you understand why tuple is different from list.

🔴 Bonus Task 8 — Object

This is the most important complex type for real-world Terraform.

Create:

server_config

with type:

object({
  name          = string
  instance_type = string
  monitoring    = bool
  disk_size     = number
})

Example:

server_config = {
  name          = "web-server"
  instance_type = "t3.micro"
  monitoring    = true
  disk_size     = 20
}

Use these values to create an EC2 instance.

So Terraform should get:

Name          → web-server
Instance type → t3.micro
Monitoring    → true
Disk size     → 20 GB
Challenge

Add validation for disk_size:

Minimum = 10 GB
Maximum = 100 GB
🎯 Your progression

Do them in this order:

Task 1 → string
    ↓
Task 2 → number
    ↓
Task 3 → bool
    ↓
Task 4 → list
    ↓
Task 5 → set
    ↓
Task 6 → map
    ↓
Task 7 → tuple
    ↓
Task 8 → object

The Bonus Task 8 is especially important because object types are commonly used in production Terraform modules.
