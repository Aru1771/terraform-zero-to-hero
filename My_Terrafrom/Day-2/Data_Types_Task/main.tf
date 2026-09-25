#list of objects access

output "complete_applications" {
value = var.applications
}

output "first_application_name" {
  value = var.applications[0].name
}

output "second_application_port" {
  value = var.applications[1].port
}

output "third_application_environment" {
  value = var.applications[2].environment
}

output "first_application_enabled_status" {
  value = var.applications[0].enabled
}

#map of objects access

output "com_apps" {
  value = var.apps
}

output "payment_app_name" {
  value = var.apps["payment"].name
}

output "user_details" {
  value = var.apps["user"].name
}


# nested objects accessing

output "application_name" {
value = var.application.name
}

output "deployment_env" {
  value = var.application.deployment.env
}

output "release_version" {
  value = var.application.deployment.release
}

output "monitoring_enabled" {
  value = var.application.monitoring.enabled
}



# accessing the list objects with nested object.


output "app_name" {
  value = var.app[0].name
}

output "app_name_2" {
  value = var.app[1].name
}

output "replicas_of_lims" {
  value = var.app[0].deployment.replicas
}

~
~
~
~
~
~
~
~
~
