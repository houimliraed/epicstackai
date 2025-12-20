variable "prefix" {
  description = "prefix for resouces in AWS"
  default     = "sp"
}
variable "Project" {
  description = "Project name for tagging resources"
  default     = "saas-pme"
}
variable "Contact" {
  description = "Contact for tagging resouces in AWS"
  default     = "houimliraed@engineergrid.com"
}
variable "db_username" {
  description = "username for epicstack app api database"
  default     = "epicstack"

}
variable "db_password" {
  description = "password for the terraform database"
  default = "WhateverYouWantButMakeSureItsSecure123!"
}