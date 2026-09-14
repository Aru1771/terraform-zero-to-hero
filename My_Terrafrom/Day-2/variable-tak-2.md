Absolutely. Since you want hands-on practice specifically on Terraform complex data types, let's make this practical and progressively difficult.

We'll focus only on:

list
set
map
object
tuple
Nested combinations
for expressions
for_each
dynamic blocks
Type constraints
Accessing nested data

No AWS resources initially—you can solve most of these using output and locals.

🟢 Task 1 — List of Objects

Create a variable:

variable "servers" {
  # define the type
}

The input should look like:

servers = [
  {
    name = "web-01"
    size = "t3.micro"
    env  = "dev"
  },
  {
    name = "web-02"
    size = "t3.small"
    env  = "prod"
  },
  {
    name = "web-03"
    size = "t3.medium"
    env  = "prod"
  }
]
Requirements
Define the correct complex type for the variable.
Create an output containing only the server names.
Create an output containing only production servers.
Create an output like:
{
  web-01 = "t3.micro"
  web-02 = "t3.small"
  web-03 = "t3.medium"
}

Concepts: list(object()), for, filtering, map creation.

🟢 Task 2 — Map of Objects

Create:

variable "applications" {
  # define type
}

Input:

applications = {
  frontend = {
    replicas = 3
    port     = 80
    image    = "nginx:1.25"
  }

  backend = {
    replicas = 2
    port     = 8080
    image    = "backend:v1"
  }

  payments = {
    replicas = 2
    port     = 9090
    image    = "payments:v2"
  }
}
Requirements

Create outputs for:

1. All application names

[
  "frontend",
  "backend",
  "payments"
]

2. All ports

{
  frontend = 80
  backend  = 8080
  payments = 9090
}

3. Applications having replicas >= 3

Expected:

{
  frontend = ...
}

Concepts: map(object()), for k, v, filtering.

🟡 Task 3 — Nested Complex Type

Create this variable:

variable "environments" {
  # define type
}

Input:

environments = {
  dev = {
    region = "ap-south-1"

    servers = [
      {
        name = "dev-web"
        size = "t3.micro"
      },
      {
        name = "dev-api"
        size = "t3.small"
      }
    ]
  }

  prod = {
    region = "us-east-1"

    servers = [
      {
        name = "prod-web"
        size = "t3.large"
      },
      {
        name = "prod-api"
        size = "t3.large"
      }
    ]
  }
}
Tasks

Create outputs for:

1. Production region
us-east-1
2. Production server names
[
  "prod-web",
  "prod-api"
]
3. Create:
{
  dev  = 2
  prod = 2
}

where the value represents the number of servers.

4. Create:
{
  dev  = ["dev-web", "dev-api"]
  prod = ["prod-web", "prod-api"]
}

Concepts: nested map(object({ ... })), list of objects, nested for.

🟡 Task 4 — Map of Lists

Create:

variable "subnets" {
  # define type
}

Input:

subnets = {
  public = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private = [
    "10.0.10.0/24",
    "10.0.11.0/24"
  ]

  database = [
    "10.0.20.0/24",
    "10.0.21.0/24"
  ]
}
Tasks

Create:

1. Number of subnets per category

{
  public   = 2
  private  = 2
  database = 2
}

2. Get only private subnets

[
  "10.0.10.0/24",
  "10.0.11.0/24"
]

3. Flatten everything into one list

[
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.10.0/24",
  ...
]

Concepts: map(list(string)), indexing, flatten().

🟠 Task 5 — Object Containing Different Complex Types

This is closer to real Terraform modules.

Create:

variable "infrastructure" {
  # define type
}

Input:

infrastructure = {
  project = "payment"

  vpc = {
    cidr = "10.0.0.0/16"
  }

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]

  subnets = {
    public = [
      "10.0.1.0/24",
      "10.0.2.0/24",
      "10.0.3.0/24"
    ]

    private = [
      "10.0.11.0/24",
      "10.0.12.0/24",
      "10.0.13.0/24"
    ]
  }

  tags = {
    Environment = "prod"
    Owner       = "devops"
    Project     = "payment"
  }
}
Tasks
Define the complete type constraint.
Output the VPC CIDR.
Output the AZ count.
Output all tags.
Output only private subnets.
Create:
{
  public  = 3
  private = 3
}

This tests whether you can model a real Terraform module input.

🔴 Task 6 — Convert List of Objects → Map

This is very important for for_each.

Input:

variable "users" {
  # define type
}
users = [
  {
    name  = "aravind"
    role  = "admin"
    team  = "devops"
  },
  {
    name  = "rahul"
    role  = "developer"
    team  = "backend"
  },
  {
    name  = "suresh"
    role  = "developer"
    team  = "frontend"
  }
]

Convert it into:

{
  aravind = {
    role = "admin"
    team = "devops"
  }

  rahul = {
    role = "developer"
    team = "backend"
  }

  suresh = {
    role = "developer"
    team = "frontend"
  }
}

Then imagine you want:

for_each = ...

Your task is to produce a map suitable for for_each.

This is a very important Terraform skill.

🔴 Task 7 — Nested for Expression

Input:

variable "teams" {
  # define type
}
teams = {
  devops = {
    members = [
      "aravind",
      "rahul"
    ]
  }

  backend = {
    members = [
      "suresh",
      "kiran"
    ]
  }

  frontend = {
    members = [
      "ravi",
      "anil"
    ]
  }
}

Create one flat list:

[
  "aravind",
  "rahul",
  "suresh",
  "kiran",
  "ravi",
  "anil"
]

Don't use flatten() initially.

Try solving it using a nested for expression.

Then solve the same problem using flatten().

🔥 Task 8 — Terraform dynamic Block

Now let's move toward real AWS Terraform.

Create a variable representing security-group rules:

security_group_rules = [
  {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },

  {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },

  {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
]

Create an AWS security group using a dynamic block so that you don't manually write three ingress blocks.

The goal is conceptually:

dynamic "ingress" {
  for_each = ...
  
  content {
    from_port   = ...
    to_port     = ...
    protocol    = ...
    cidr_blocks = ...
  }
}

This is one of the most useful complex-data-type exercises for real Terraform work.

🧨 Task 9 — Complex for_each

Create:

applications = {
  frontend = {
    replicas = 2
    port     = 80
  }

  backend = {
    replicas = 3
    port     = 8080
  }
}

Imagine you're creating one resource per application:

resource "..." "app" {
  for_each = var.applications

  # use each.key
  # use each.value
}

Your task is to create outputs that demonstrate:

each.key
each.value.replicas
each.value.port

Then create a transformed map:

{
  frontend = "frontend:80"
  backend  = "backend:8080"
}
🏆 Final Challenge

Don't look at previous tasks while solving this one.

Create a variable called:

variable "clusters" {
  # complete type constraint
}

Input:

clusters = {
  dev = {
    region = "ap-south-1"

    node_groups = {
      general = {
        instance_type = "t3.medium"
        desired       = 2
        min           = 1
        max           = 3
      }

      spot = {
        instance_type = "t3.large"
        desired       = 2
        min           = 1
        max           = 5
      }
    }
  }

  prod = {
    region = "us-east-1"

    node_groups = {
      general = {
        instance_type = "m5.large"
        desired       = 3
        min           = 2
        max            = 5
      }

      memory = {
        instance_type = "r5.large"
        desired       = 2
        min           = 1
        max           = 4
      }
    }
  }
}
Produce these outputs:

1. Cluster regions

{
  dev  = "ap-south-1"
  prod = "us-east-1"
}

2. Node-group names

{
  dev  = ["general", "spot"]
  prod = ["general", "memory"]
}

3. All node groups as a flat structure suitable for for_each

Something like:

{
  "dev-general" = {...}
  "dev-spot"    = {...}
  "prod-general" = {...}
  "prod-memory"  = {...}
}

4. Find all node groups where max >= 5.

5. Create a map containing:

{
  "dev-general"  = "t3.medium"
  "dev-spot"     = "t3.large"
  "prod-general" = "m5.large"
  "prod-memory"  = "r5.large"
}
Recommended order

Don't try all of them at once:

Today:

Task 1 → Task 2 → Task 3 → Task 4

Then:

Task 5 → Task 6 → Task 7

Finally:

Task 8 → Task 9 → Final Challenge
