
variable "custom_vpc" {
  default = "10.10.0.0/16"
}

variable "custom_subet1" {
  default = "10.10.1.0/24"
}

variable "custom_subet2" {
  default = "10.10.2.0/24"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 443, 22, 3389]
}

variable "ip_sg" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "db_user" {
  type    = string
  default = "admin"

}

variable "db_password" {
  default = "admin1234"

}