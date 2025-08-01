import {
  to = azurerm_resource_group.rgs # The desired resource address in your state
  id = "/subscriptions/5fffa1ff-217c-45ea-ad98-83726d1375b9/resourceGroups/rg1"
}

# for generate a file from terraform directly run this command and fill the above id and to option
# terraform plan  --generate-config-out=generated.tf 
# it will generate a generated.tf file that contaisn all info copied the resource from portal
# above command will not create tf.state file it will be created after using terraform apply command