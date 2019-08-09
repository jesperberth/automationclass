$email = "jesper@santaz.dk"
$name = "Jesper Santaz"

function CreateUser {
    param (

    )
    $emailStringTmp = $email -replace "@","_"
    $emailString = $emailStringTmp -replace "\.","_"
    write-host $emailString
    $rgname = $emailString

    New-AzureADMSInvitation -InvitedUserDisplayName $name -InvitedUserEmailAddress $email -InviteRedirectURL https://portal.azure.com -SendInvitationMessage $true
    New-AzureRmResourceGroup -Name $rgname -Location "North Europe"
    New-AzureADGroup -DisplayName $rgname -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"

    $group = Get-AzureADGroup -SearchString $rgname | Select-Object ObjectId

    New-AzureRmRoleAssignment -ObjectId $group.ObjectId -RoleDefinitionName Contributor -ResourceGroupName $rgname
}
CreateUser