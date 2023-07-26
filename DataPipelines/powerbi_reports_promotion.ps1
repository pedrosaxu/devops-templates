
######################## Variables ########################
Write-Host "##############################################"
Write-Host "Setando variaveis de ambiente..."

# Pipeline variables
$AppId = $($env:AppId)
$ClientSecret = $($env:ClientSecret)
$TenantId = $($env:TenantId)
$Source_Workspace = $($env:Source_Workspace)
$Dest_Workspace = $($env:Dest_Workspace)
$System_DefaultWorkingDirectory = $($env:System_DefaultWorkingDirectory)
$path = $System_DefaultWorkingDirectory + "\pbi\"

### Não alterar abaixo - transformando o secret do Service Principal em variável segura do Powershell ###
$PbiSecurePassword = ConvertTo-SecureString $ClientSecret -Force -AsPlainText
$PbiCredential = New-Object Management.Automation.PSCredential($AppId, $PbiSecurePassword)


Write-Host "App ID: "$AppId
Write-Host "Tenant ID: "$TenantId
Write-Host "Source Workspace ID: "$Source_Workspace
Write-Host "Dest Workspace ID: "$Dest_Workspace
Write-Host "System Working Dir: "$System_DefaultWorkingDirectory

######################## Instalação do módulo MicrosoftPowerBIMgmt ########################
Write-Host "##############################################"
Write-Host "Instalacao do modulo MicrosoftPowerBIMgmt..."
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module -Name MicrosoftPowerBIMgmt

######################## Importação do módulo MicrosoftPowerBIMgmt ########################
Write-Host "##############################################"
Write-Host "Importacao do modulo MicrosoftPowerBIMgmt..."
Import-Module MicrosoftPowerBIMgmt

######################## Conectando ao serviço do PowerBI ########################
Write-Host "##############################################"
Write-Host "Conectando ao servico do PowerBI..."
Connect-PowerBIServiceAccount -ServicePrincipal -TenantId $TenantId -Credential $PbiCredential

######################## Inicia o Donwload de todos os arquivos do workSpace ########################
Write-Host "##############################################"
Write-Host "Baixando todos os relatorios do Workspace de origem..."
$relatorios = Get-PowerBIReport -WorkspaceId $Source_Workspace

Write-Host "Relatorios: "
Write-Host $relatorios

# local onde está sendo criado a pasta para salvar os arquivo PBIX
# Caminho para a pasta a ser criada

Write-Host "##############################################"
Write-Host "Criando diretorio para salvar os relatorios..."
Write-Host $path
$arquivo = New-Item -ItemType Directory -Path $path

Write-Host "##############################################"
Write-Host "Baixando relatorios..."
$i = 0
$qtdderelatorios = $relatorios.count


foreach ($relatorio in $relatorios){
  $i++
  Write-Host "Baixando "$i "|" $qtdderelatorios
  $arquivo = $path + $relatorio.name + ".pbix"
  Write-Host $relatorio.name
  Export-PowerBIReport -Id $relatorio.Id -WorkspaceId $Source_Workspace -OutFile $arquivo
  }

######################## Processo para publicar os relatórios  ########################
Write-Host "##############################################"
Write-Host "Listando arquivos para publicacao..."
$files = Get-ChildItem $path -Recurse -Include *.pbix

Write-Host "##############################################"
Write-Host "Publicando relatorios no Workspace de Destino..."
$j = 0
$qtdderelatorios = $files.count

foreach ($file in $files) {
  $j++
  Write-Host "Carregando $j | $qtdderelatorios"
  Write-Host $file.FullName

  $arquivo = $file.FullName
  Write-Host $arquivo

  New-PowerBIReport -Path $arquivo -WorkspaceId $Dest_Workspace -Name $file.Name -ConflictAction CreateOrOverwrite
}
