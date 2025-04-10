locals {
  environment = lower(var.environment)
  project_id  = format("%s", lower(var.project_id))
}