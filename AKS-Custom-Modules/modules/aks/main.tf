resource "azurerm_kubernetes_cluster" "this" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "mohanaks"

  default_node_pool {
    name                = var.node_pool_name
    vm_size             = var.vm_size
    vnet_subnet_id      = var.subnet_id

    enable_auto_scaling = true
    min_count           = var.min_nodes
    max_count           = var.max_nodes

    type                = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"

    service_cidr       = "10.1.0.0/16"
    dns_service_ip     = "10.1.0.10"
    outbound_type      = "loadBalancer"
  }
}
