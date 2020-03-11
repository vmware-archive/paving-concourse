variable "project" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "service_account_key" {
  type = string
}

variable "hosted_zone" {
  description = "Hosted zone name (e.g. foo is the zone name and foo.example.com is the DNS name)."
}

variable "availability_zones" {
  description = "Requires exactly THREE availability zones that must belong to the provided region."
  type        = list
  default     = ["us-central1-a", "us-central1-b", "us-central1-c"]
}
