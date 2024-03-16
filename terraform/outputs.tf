output "db_instance_master_user_secret_arn" {
  description = "The ARN of the master user secret (Only available when manage_master_user_password is set to true)"
  value       = module.db.db_instance_master_user_secret_arn
}
