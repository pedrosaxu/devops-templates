
## Cenários

#### Cenário Azure:
  - 4 máquinas virtuais 
      - 2 com disco attachado (azurerm_virtual_machine) -> deprecated
      - 3 com disco novo (azure_windows_virtual_machine) -> não suporta attachment 
  - Recursos de redes

#### Cenário AWS:
  - 5 máquinas virtuals
  - Recursos de redes

## Ferramentas & Links

- Cycloid.io -> https://www.cycloid.io
- Terracognita -> https://github.com/cycloidio/terracognita
- Azure Terrafy -> https://github.com/Azure/aztfy

---
### Import manual
- Importar VPC Manualmente na AWS: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
- Importar VNET Manualmente na Azure: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network


---

### Terracognita 

#### Pré-requisitos
 - Cloud cli installation
 - Cloud cli login
    - aws configure
    - az login
    - ...
 - Azure: app registration com role de OWNER na subscription
 - terraform instalation

#### Prós
   - Mais amplo - Multicloud
   - Referencia alguns recursos
   - Faz interpolação 

#### Contras
   - Não consegue tratar erros, então acaba sendo necessário exclude alguns recursos
   - Plan geralmente da algum erro/falha
   - Documentação pior
   - Na Azure, requer muitas informações (app registration, subs ID, tenant ID)

#### Comandos adicionais:

```
terracognita azurerm resources
terracognita aws resources
```


#### Azure CLI Info:
```
az account list -o table (Tenant e Subscription ID)
az group list -o table (Resource Groups)
az ad app list -o table (App Registrations)
````

#### Importação da Azure:
```
terracognita azurerm \
--interpolate \
--hcl resources.tf \
--tfstate terraform.tfstate \
--tenant-id <tenant_id> \
--subscription-id <subscription_id> \
--client-id <id_app_registration> \
--client-secret <value_app_registration_token> \
--resource-group-name rg-local \
--exclude azurerm_windows_virtual_machine --exclude azurerm_linux_virtual_machine \
--exclude azurerm_policy_definition --exclude azurerm_policy_set_definition
```


#### Importação da AWS:
```
terracognita aws \
--interpolate \
--hcl resources.tf \
--tfstate terraform.tfstate \
--aws-default-region us-east-1
```

---
### Terrafy 

#### Prós
   - Mais estável/bonito
   - Documentação melhor
   - Trata erros > Quando ele não consegue validar alguma importação, é possível declarar qual o terraform resource daquele item 
   - O init/plan funcionou perfeitamente
   - Não precisa de nada além do Azure CLI Login

#### Contras
   - Somente Azure
   - Não referencia os recursos

#### Importação da Azure:
```aztfy rg rg-local```

