param(
    [Parameter(Mandatory)]
    [string]$Output
)

Select-MgProfile -Name "beta"
Connect-MgGraph -Scopes "CloudPC.Read.All"
$CloudPCs = Get-MgDeviceManagementVirtualEndpointCloudPC -Property "DisplayName"
$DisplayNames = $CloudPCs | Select -ExpandProperty DisplayName
Write-Output $DisplayNames

$Outarray = @()

foreach ( $Name in $DisplayNames )
{
    $Outarray += New-Object PsObject -property @{
    'DisplayName' = $Name
     }
}
$Outarray | Export-Csv -Path $Output -NoTypeInformation
Disconnect-MgGraph