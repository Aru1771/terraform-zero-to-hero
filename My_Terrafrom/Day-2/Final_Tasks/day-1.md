<img width="807" height="695" alt="image" src="https://github.com/user-attachments/assets/71a46508-c2da-425a-8c77-a01bfa126756" />

var.tf 

    variable "app_name" {
        type = string
      
    }
    
    variable "environment" {
        type = string
    
        validation {                                                   #Environment must be dev, stage or prod.
            condition = contains(["dev", "stage", "prod"], var.environment)  #contains() checks whether a value exists in a list.
            error_message = "environment must be one of 'dev', 'stage', or 'prod'. "
        }
    }
    
    variable "app_port" {
        type = number
    
        validation {
            condition = var.app_port >= 1 && var.app_port <= 65535
            error_message = "app_port must be a valid port number between 1 and 65535."    #- && means both conditions must be true.
        }
    }
    
    variable "monitoring_enabled" {
        type = bool
    }
    
    variable "replica_count" {
        type = number
    
        validation {
            condition = var.replica_count >= 1
            error_message = "replica_count must be greater than or equal to 1."
    
        }
    }
    
    variable "application_ports" {
        type = list(number)
    }
    
    variable "allowed_environments" {
        type = set(string)
    }
    variable "common_tags" {
        type = map(string)
    }


tfvars:

    app_name = "Empower"
    
    environment = "Production"
    
    app_port = 8080
    
    monitoring_enabled = true
    
    replica_count = 3
    
    application_ports = [8080, 8081, 8082]
    
    allowed_environments = ["Prod", "stage", "dev"]
    
    common_tags = {
        managed_by = "Terraform",
        environment = "prod",
        application = "empower"
    }
    
