locals {
  prefered_name = "${var.project_name}-vpc-${var.environment}"
  prefered1_name = "${var.project_name}-ec2-${var.environment}"
  prefered_subnet_name = "${var.project_name}-pub-subnet-${var.environment}"
  prefered_sg_name = "${var.project_name}-sg-${var.environment}"
  common_tags = {
    project_name = var.project_name
    managed_by = "terraform"
    environment = var.environment

}

