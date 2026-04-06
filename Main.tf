terraform{
  //terraform version and provider details
     required_version = ">=1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.43.0"
    }
  }
    cloud{
            organization = "saloni180"
            workspaces{
                name = "Remote"
            }
    }
}
//sal
provider azurerm{
    features{}
//test
}
