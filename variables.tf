variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
  sensitive   = false
}

# variable "public_subnet" {
#     description = "CIDR Public subnet"
#     type = string
# }

# variable "private_subnet" {
#     description = "CIDR Private subnet"
#     type = string
# }

variable "subnets" {
  description = "Lista de Subnets"
  type        = list(string)

}

variable "tags" {
  description = "tags del proyecto"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Parametros de la Instancia"
  type        = map(string)

}

variable "enable_monitoring" {
  description = "Habilita el despliegue de un servidor de monitoreo"
  type        = bool

}


variable "ingress_port_list" {
  description = "Lista de puertos de Ingress"
  type        = list(number)
}

variable "access_key" {

}

variable "secret_key" {

}

variable "culeame" {

}
