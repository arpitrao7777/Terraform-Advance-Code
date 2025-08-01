# resource "azurerm_resource_group" "rgs" {}

# terraform import azurerm_resource_group.rgs /subscriptions/5fffa1ff-217c-45ea-ad98-83726d1375b9/resourceGroups/rg1
# this command is used to import the data of resource group from portal to tf state
# you can manually fill the name and location otherwise use different method to print all arguments in another file