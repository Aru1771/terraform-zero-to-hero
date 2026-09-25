list of objects
---------------

applications = [

{

name = "Empower"
port = 8081
environment = "prod"
enabled = true
},

{
name = "lims"
port = 8082
environment = "dev"
enabled = true

},

{
name = "non-core"
port = 8083
environment = "stage"
enabled = true
}

]


MAP OF OBJECTS
---------------
apps = {

payment = {
name = "gpay"
port = 90
env = "india"
},

user = {
name = "aravind"
port = 90
env = "india"
}
}

~
~


#nested objects declaration

application = {

name = "Empower"

deployment = {

env = "prod"
release = 1.0

}

monitoring = {

enabled = true
path = "/home/health"

}

}



# listed objects with nested object.
# By using the blue print which we have mentioned in the var.tf file we can create n number of list of objects with nested objects. we are sperating objects with ",".

app = [

{

name = "lims"

deployment = {

environment = "stage"
replicas = 4


}
},

{

name = "non-core"

deployment = {

environment = "dev"

replicas = 5
}
}

]
~
~
~

