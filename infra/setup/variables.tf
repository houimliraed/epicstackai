variable "tf-state-bucket" {
  description = "Name of the S3 bucket in aws storing the terraform state and lock"
  default = "saas-pme-tf-state"
}
variable "Project" {
  description = "Name of the project for tagging resources"
  default = "saas-pme"
}
variable "Contact" {
  description = "Contact info for tagging resouces"
  default = "houimliraed@engineergrid.com"
}