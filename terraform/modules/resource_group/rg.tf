resource "azurerm_resource_group" "Azuredevops" {
  name     = var.resource_group
  location = var.location

    tags     = {
    DeploymentId = "244467"
    LaunchId     = "1345"
    LaunchType   = "ON_DEMAND_LAB"
    TemplateId   = "1243"
    TenantId     = "203"
  }
}
