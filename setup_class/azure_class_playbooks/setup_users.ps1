function CreateUser {
    param (
             
    )
    $location = "North Europe"
    $emailStringTmp = $email -replace "@","_"
    $emailString = $emailStringTmp -replace "\.","_"
    write-host $emailString
    $rgname = $emailString
    
    #$uniqtext1 = 1..99 | Get-Random -Count 1
    #$uniqtext2 = 1..99 | Get-Random -Count 1
    #$sec = Get-Date -Second
    #write-host $uniqtext2
    #write-host $sec
    #$uniqname = 

    New-AzureADMSInvitation -InvitedUserDisplayName $name -InvitedUserEmailAddress $email -InviteRedirectURL https://portal.azure.com -SendInvitationMessage $true
    New-AzureRmResourceGroup -Name $rgname -Location $location
    New-AzureADGroup -DisplayName $rgname -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"

    $group = Get-AzureADGroup -SearchString $rgname | Select-Object ObjectId

    New-AzureRmRoleAssignment -ObjectId $group.ObjectId -RoleDefinitionName Contributor -ResourceGroupName $rgname

    #New-AzStorageAccount -Name $uniqname -ResourceGroupName $rgname -Location $location -SkuName Standard_LRS -Kind StorageV2
}
$email = Read-Host -Prompt 'Input email'
$name = Read-Host -Prompt 'Input name'
CreateUser