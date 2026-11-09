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


Task 2: 

<img width="901" height="810" alt="image" src="https://github.com/user-attachments/assets/74aada4a-d2b6-4a60-967c-604632d32d64" />

Vars.tf:

        variable "docker_config" {
            type = object({
                image = string
                tag = string
                resources = object({
                    cpu = string
                    memory = string
                })
        
                ports = list(number)
            })
        
        }
        
        variable "environment_configuration" {
            type = map(object({
                environment = string
                instance_type = string
                replicas = number
                monitoring = bool
            }))
        }

tfvars:

    docker_config = {
        image = "empower-app"
        tag = "FR4"
    
        resources = {
            cpu = "500m"
            memory = "200mi"
        }
    
        ports = [8081, 8082, 8083]
    }
    
    environment_configuration =  {
        dev = {
            environment = "dev"
            instance_type = "t2.micro"
            replicas = 1
            monitoring = false
        },
    
        stage = {
            environment = "stage"
            instance_type = "t2.small"
            replicas = 2
            monitoring = true
        },
    
        prod = {
            environment = "prod"
            instance_type = "t2.medium"
            replicas = 3
            monitoring = true
        }
    
    
    }



<img width="956" height="638" alt="image" src="https://github.com/user-attachments/assets/1aa8fc38-85e3-42bb-abc7-ff76e1952f40" />
<img width="927" height="655" alt="image" src="https://github.com/user-attachments/assets/43f72e0d-5f0c-4126-b007-d8de58d6d821" />
<img width="660" height="738" alt="image" src="https://github.com/user-attachments/assets/919e75fe-5699-4e10-8600-a1e5e36cff0b" />
<img width="745" height="488" alt="image" src="https://github.com/user-attachments/assets/7e35bd8e-0f59-448c-ab7c-6b98ede094ae" />
<img width="816" height="756" alt="image" src="https://github.com/user-attachments/assets/14e1b7a2-d6b3-443f-adc7-39f971e4a467" />
<img width="941" height="395" alt="image" src="https://github.com/user-attachments/assets/3fdd7fc6-03f8-472d-b970-cbd9a8e5239f" />
<img width="502" height="730" alt="image" src="https://github.com/user-attachments/assets/a4380a0e-b880-4d30-9553-4df9402a8d31" />
<img width="826" height="392" alt="image" src="https://github.com/user-attachments/assets/eeed8314-dd83-46a8-b9bd-19c55abc7864" />
<img width="970" height="832" alt="image" src="https://github.com/user-attachments/assets/7458d5f5-7d9a-4ffb-99d0-2ddd0e9e82cb" />
<img width="940" height="737" alt="image" src="https://github.com/user-attachments/assets/23a5bbe0-eabe-466c-ba94-8888414c16cd" />

vars.tf:

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
            
            variable "docker_config" {
                type = object({
                    image = string
                    tag = string
                    resources = object({
                        cpu = string
                        memory = string
                    })
            
                    ports = list(number)
                })
            
            }
            
            variable "environment_configuration" {
                type = map(object({
                    image = string
                    tag = string
                    replica_count = number
                    monitoring = bool
            
                    resources = object({
                        cpu = string
                        memory = string
                    })
                }))
            }
            
            
            variable "environment_tags" {
            
                type = map(map(string))
                description = "A map of maps containing environment-specific tags."
            }



tfvars.tf

        app_name = "Empower"
        
        environment = "prod"
        
        app_port = 8080
        
        monitoring_enabled = true
        
        replica_count = 3
        
        application_ports = [8080, 8081, 8082, 8081, 8080, 8082, 8081]
        
        allowed_environments = ["Prod", "stage", "dev"]
        
        common_tags = {
            managed_by = "Terraform",
            environment = "prod",
            application = "empower"
        }
        
        
        docker_config = {
            image = "empower-app"
            tag = "FR4"
        
            resources = {
                cpu = "500m"
                memory = "200mi"
            }
        
            ports = [8081, 8082, 8083]
        }
        
        environment_configuration =  {
            
            prod = {
                image = "empower3-prod"
                tag = "fr4"
                replica_count = 3
                monitoring = true
                resources = {
                    cpu = "500m"
                    memory = "200mi"
                }
            },
        
            stage = {
        
                image = "empower3-stage"
                tag = "fr4"
                replica_count = 2
                monitoring = true
                resources = {
                    cpu = "400m"
                    memory = "120mi"
                }
            },
        
            dev = {
        
                image = "empower3-dev"
                tag = "fr4"
                replica_count = 1
                monitoring  = false
                resources = {
                    cpu = "200m"
                    memory = "100mi"
                }
            }
        
        
        }
        
        
        environment_tags = {
        
            prod = {
                environment = "prod"
                owner = "Devops Team"
            }
        
            stage = {
                environment = "stage"
                owner = "Devops Team"
            }
        
            dev = {
                environment = "dev"
                owner = "Devops Team"
            }
        
        
        }


output.tf



        output "resource_prefix" {
            value = local.resource_prefix
        }
        
        
        output "deployment_config" {
            value = local.deployment_config
          
        }
