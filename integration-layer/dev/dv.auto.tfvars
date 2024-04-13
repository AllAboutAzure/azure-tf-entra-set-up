###############################################################################################
# this file will have s values which create resources in Dev Environment
# Original Author: @devopswithyoge
# Creation Date: 13/04/2024
# Version: 0.1
# Modification: nil
###############################################################################################


subscription_id = "Development Environment Subscription"

remote_state_backend = {
    storage_account = "Remote File Storage Account Name"
    storage_container = "Remote File Storage Account Container Name"
    file_name = "Remote File State File Name"
    rg ="Remote Resource Group Name"
    subscription = "Remote Resource group subscription ID"
}

location = "eastus"

resource_groups = {
    integration = {
        name = "integration"
        tags = {
            project = "azure integration service"
        }
    }
}

entra_ad_groups = [
    
    "functionapps_group",
    "logicapps_group"
]


# virtual_network = {
#     //TODO: to be added later
# }

apims = {
    integration-api = {
        name = ""
        sku = ""
        publisher_name = ""
        publisher_email = ""

        rg_name = ""
        public_ip = "" #To Enable internal network
        virtual_network_type = "internal"
        enable_maange_identity = true
        virtual_network_configuration = {
            subnet_key = "subnet_apim"
        }
        rbac = [
            {
                resource_id = ""
                role_name = "Storage Blob Data Contributor"
            }
        ]
    }
}

# apim_products = []

# apim_apis = []

entra_app_regs = [
    {
        name = "api-__#environment_abbreviation#__-shopping-backend"
        owner = "__#object_id#__"
        app_roles = [
            {
                "allowed_member_types" = ["User","Application"]
                "description" = "Allows get request to get item details from storage account"
                "display_name" = "shopping.get"
                "enabled" = true
                "value" = "shopping.get"
            },
            {
                "allowed_member_types" = ["User","Application"]
                "description" = "Allows post request to post item details from storage account"
                "display_name" = "shopping.post"
                "enabled" = true
                "value" = "shopping.post"
            }
        ]
        # service principal config
        create_sp = true
        create_sp_secret = true
        sp_membership = [] // can add az groups to which this service princ can be a member and can be exposed to external applications
        secret_management = {
            keyvault_name = "kv-__#environment_abbreviation#__-integration"
        }
    }
]
  
app_service_environments = [
    {
        name = "ase-__#environment_abbreviation#__-integration"
        ase_zone_redundant = false
        subnet_key = "subnet_asev3"
        internal_load_balancing_mode = "Web, Publishing"
        rg_name = "rg-__#environment_abbreviation#__-integration"
        tags = {
            Resource = "App Service Environment"
        }
    }
]

app_service_plans = [
    {
        name = "asp-__#environment_abbreviation#__-logic-apps"
        rg_name = "rg-__#environment_abbreviation#__-integration"
        os_type = "Windows"
        sku = "I1V1"
        ase = "ase-__#environment_abbreviation#__-integration"
    },
    {
        name = "asp-__#environment_abbreviation#__-function-apps"
        rg_name = "rg-__#environment_abbreviation#__-integration"
        os_type = "Windows"
        sku = "I1V1"
        ase = "ase-__#environment_abbreviation#__-integration"
    }
]
  
function_apps = [
    {
        name = "function-app-__#environment_abbreviation#__-shopping-get"
        rg_name = "rg-__#environment_abbreviation#__-integration"
        asp_key = "asp-__#environment_abbreviation#__-function-apps"
        storage_account_key = ""
        app_insight_key = ""
        version = "~4"
        functionapp_access_role = "azgroup-__#environment_abbreviation#__-functionapps_group"

        app_settings = {

        }

        always_on = true
        identity = {
            type = "SystemAssigned, UserAssigned"
            umid = "id-__#environment_abbreviation#__-integration"
        }

        tags = {
            "Type" = "Function App"
            "Usage" = "get Shopping list"
        }
    }
] 
  
logic_apps = [
    {
        name = "logic-app-__#environment_abbreviation#__-shopping-post"
        rg_name = "rg-__#environment_abbreviation#__-integration"
        asp_key = "asp-__#environment_abbreviation#__-logic-apps"
        storage_account_key = ""
        app_insight_key = ""
        version = "~4"
        functionapp_access_role = "azgroup-__#environment_abbreviation#__-logicapp_group"

        app_settings = {

        }

        always_on = true
        identity = {
            type = "SystemAssigned"
        }

        tags = {
            "Type" = "Logic App"
            "Usage" = ""
        }
    }
] 
  
keyvaults = [
    {
        name = ""
        sku = ""
        enable_disk_encryption = ""
        enable_purge_protection = 
        rg_name = ""
        tenant_id = ""
        log_id = ""
        public_network_access = 
        access_policy = []
        rbac = []
    }
] 
  
storage_accounts = [
    {
        name = "storageaccount__#environment_abbreviation#__integration"
        account_tier = "Standard"
        rg_name = "rg-__#environment_abbreviation#__-integration"
        hns_enabled = false
        public_network_access = false 
        account_replication_type = "LRS"
        secret_management = {
            keyvault_name = ""
        }
        rbac = [
            {
                role_name = ""
                entra_group_name = ""
            }
        ]
    }
] 