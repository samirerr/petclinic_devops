resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "petclinicstorage" {
  name                     = var.name_storage
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind = var.account_kind
  min_tls_version = var.min_tls_version

  network_rules {
    default_action  = var.default_action
  }
}

resource "azurerm_mysql_flexible_server" "petclinic-server" {
  name                   = var.name_server_mysql
  resource_group_name    = azurerm_resource_group.rg.name
  location               = var.location
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  backup_retention_days  = 7
  geo_redundant_backup_enabled = true
  sku_name = var.sku_name
  version = var.db_version
  zone = 1
  storage {
    auto_grow_enabled = true
    iops = 360
    size_gb = var.size_gb
  }

  high_availability {
    mode = "ZoneRedundant"
    standby_availability_zone = 2
  }

}

resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {

    availability_zones  = [1, 2, 3]
    name                = "nodepool"
    vm_size             = "Standard_DS2_v2"
    os_disk_size_gb     = 100
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    node_count          = var.system_node_count
    min_count           = var.system_min_count
    max_count           = var.system_max_count

  }
 
network_profile {
    network_plugin      = "kubenet"
    load_balancer_sku   = "standard"
    pod_cidr            = "192.168.1.0/24"
    service_cidr        = "192.168.2.0/24"
  }

role_based_access_control {
    enabled = true
  }

identity {
    type = "SystemAssigned"
  }
  }
provider "azurerm" {
  features {}
}
