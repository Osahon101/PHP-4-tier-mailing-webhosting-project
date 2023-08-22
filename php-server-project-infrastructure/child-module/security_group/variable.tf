variable "bastion_sg_name" {
  description = "Name of the Bastion Host Security Group"
  type        = string
  default     = "Bastion-sg"
}

variable "front_lb_sg_name" {
  description = "Name of the Frontend/External Load Balancer Security Group"
  type        = string
  default     = "front-lb-sg"
}

variable "Webserver_sg_name" {
  description = "Name of the Webservers Security Group"
  type        = string
  default     = "Webserver-sg"
}

variable "backend_lb_sg_name" {
  description = "Name of the Backend Load Balancer Security Group"
  type        = string
  default     = "backend-lb-sg"
}

variable "Appserver_sg_name" {
  description = "Name of the Appservers Security Group"
  type        = string
  default     = "Appserver-sg"
}

variable "database_sg_name" {
  description = "Name of the Database Security Group"
  type        = string
  default     = "database-sg"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string

}