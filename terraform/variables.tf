variable "myname" {
  description = "Add my name into names"
  type        = string
  default     = "azmi1"
}

variable "is_production" {
  type        = bool
  default     = false
}

variable "to_create" {
  type        = bool
  default     = false
}