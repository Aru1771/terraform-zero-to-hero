description = "account env"
type = string


}

variable "instance_type" {
description = "instance type"
type = string

}

variable "instance_count" {
description = "instance count"
type = number
validation {
condition = var.instance_count >= 1
error_message = "instance count should be >=1"
}
validation {

condition = var.instance_count <= 5
error_message = "instance count should be <= 5 "
}
}

variable "instance_volume" {
description = "instance count for ec2"
type = number

}

variable "ami_id" {
description = "instance ami"
type = string

}


variable "monitoring" {
description = "monitoring for services"
type = bool


}



variable "vpc_id" {
description = "vpc_id"
type = string


}


variable "subnet_cidr_block" {
description = "subnet cider block"
type = list(string)


}

variable "az" {
description = "availability zone for subnets"
type = list(string)

}



variable "ingress_cidr" {
description = "ingress cidrblock range"
type = set(string)

}


variable "ports_protocols" {
description = "ingress from port"
type = tuple([number,string,number])


}


variable "ec2_ins" {
description = "my new ec2 with object type"
type = list(object({

ec2_name = string
ec2_type = string
ec2_ami_id = string
ec2_count = number

}))


}



variable "tags" {
type = map(string)


}


variable "applications" {
type = list(object({
name = string
port = number
environment = string
enabled = bool

}))
}

variable "apps" {
  type = map(object({
    name = string
    port = number
    env = string
  }))
}


# nested object variables

variable "application" {
type = object({
name = string

deployment = object({

env = string
release = number
})

monitoring = object({

enabled = bool
path = string

})


})

}


# nested objects in list in this we useing list(object) with nested objects.
#=============================================================================


variable "app" {
  type = list(object({
    name = string

    deployment = object({
      environment = string
      replicas = number
    })

  }))
}





