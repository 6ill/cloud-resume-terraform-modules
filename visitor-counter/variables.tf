variable "table_name" {
  description = "The name of table for storing visitor counter"
  type        = string
}

variable "lambda_path" {
  description = "The directory path of the lambda function"
  type        = string
}

variable "lambda_name" {
  description = "The name of the lambda function"
  type        = string
}

variable "cors_allowed_origins" {
  description = "List of origins allowed to call the API"
  type        = list(string)
  default     = ["*"]
}

variable "notification_email" {
  description = "The email address destination for receiving notifacation about lambda metrics"
  type        = string
}
