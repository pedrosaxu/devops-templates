# PowerShell Script to Promote Power BI Reports between Workspaces
This PowerShell script is designed to **download all Power BI reports from a source workspace and publish them to a destination workspace**. It is intended to be used in an Azure Release Pipeline, but you can run it elsewhere, just make sure you have the [MicrosoftPowerBIMgmt](https://docs.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps) module installed, and set the environment variables below.

> The step of installation of MicrosoftPowerBIMgmt is sadly taking longer than expected [~8min]. Please share if you know a way to speed it up.

## Prerequisites
- [Service Principal with PowerBI Admin Rights](https://learn.microsoft.com/en-us/power-bi/developer/embedded/embed-service-principal)


## Variables
The script sets the following environment variables:

- `$AppId`: The ID of the Azure AD application used to authenticate with the Power BI service.
- `$ClientSecret`: The client secret of the Azure AD application.
- `$TenantId`: The ID of the Azure AD tenant.
- `$Source_Workspace`: The ID of the source Power BI workspace.
- `$Dest_Workspace`: The ID of the destination Power BI workspace.
- `$System_DefaultWorkingDirectory`: The default working directory of the system.
- `$path`: The path where the downloaded reports will be saved.

## Installation of MicrosoftPowerBIMgmt Module
The script installs the MicrosoftPowerBIMgmt module using the `Install-Module` cmdlet.

## Connection to Power BI Service
The script connects to the Power BI service using the `Connect-PowerBIServiceAccount` cmdlet.

## Downloading Reports
The script downloads all reports from the source workspace using the `Get-PowerBIReport` and `Export-PowerBIReport` cmdlets.

## Publishing Reports
The script publishes the downloaded reports to the destination workspace using the `New-PowerBIReport` cmdlet.

## Usage
To use this script in an Azure Release Pipeline, you can add a PowerShell task and copy the script into the task. You will also need to set the environment variables listed above in the pipeline variables.