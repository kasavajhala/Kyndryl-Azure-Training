module "resource_group" {
  source = "./modules/resource-group"
  resource_group_name = var.resource_group_name
  location = var.location
}

module "network" {
  source = "./modules/network"
  resource_group_name = module.resource_group.name
  location = var.location
  vnet_name = var.vnet_name
  address_space = var.vnet_address_space
  subnet_name = var.subnet_name
  subnet_prefix = var.subnet_address_prefix
}

module "aks" {
  source = "./modules/aks"
  resource_group_name = module.resource_group.name
  location = var.location
  aks_cluster_name = var.aks_cluster_name
  subnet_id = module.network.subnet_id
  node_pool_name = var.node_pool_name
  vm_size = var.vm_size
  min_nodes = var.min_nodes
  max_nodes = var.max_nodes
}
