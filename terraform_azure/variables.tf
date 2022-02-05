variable "resource_group_name" {
  type        = string
  default = "petclinic-test"
}

variable "location" {
  type        = string
  default = "francecentral"
}

variable "name_storage" {
  type        = string
  default = "petclinicstorage"
}

variable "account_kind" {
  type        = string
  default = "FileStorage"
}


variable "account_tier" {
  type        = string
  default = "Standard"
}

variable "account_replication_type" {
  type        = string
  default = "GRS"
}

variable "min_tls_version" {
  type        = string
  default = "TLS1_2"
}

variable "default_action" {
  type        = string
  default = "Allow"
}

variable "name_server_mysql" {
  type        = string
  default = "petclinic-server1"
}

variable "administrator_login" {
  type        = string
  default = "petclinic"
}

variable "administrator_password" {
  type        = string
  default = "Groupe123"
}

variable "sku_name" {
  type        = string
  default = "B_Standard_B1ms"
}

variable "db_version" {
  type        = string
  default = "8.0.21"
}


variable "size_gb" {
  type        = number
  default = "20"
}

variable "cluster_name" {
  type        = string
  default = "petclinic-myaks"
}

variable "kubernetes_version" {
  type        = string
  default = "1.21.7"
}

variable "system_node_count" {
  type        = number
  default = "2"
}

variable "system_min_count" {
  type        = number
  default = "2"
}

variable "system_max_count" {
  type        = number
  default = "5"
}

variable "acr_name" {
  type        = string
  default = "petclinic4acr"
}

