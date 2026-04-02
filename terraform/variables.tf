variable "namespace_name" {
  description = "The name of our practice namespace"
  type        = string
  default     = "terraform-lab"
}

variable "app_label" {
  description = "Label to apply to our resources"
  type        = string
  default     = "my-practice-app"
}
