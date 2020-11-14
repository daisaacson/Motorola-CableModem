Function New-MotorolaSession {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias("CN", "Motorola", "Moto")]
        [String]
        $ComputerName = $motorola,

        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [PSCredential[]]
        $Credential,

        [Switch]
        $PassThru
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "/goform/login"
        $formuser = "loginUsername"
        $formpassword = "loginPassword"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            try {
                if ($Credential.UserName -and $Credential.Password) {
                    $username = $Credential.UserName
                    $password = $Credential.Password
                } else {
                    Write-Verbose "Using Default username and password"
                    $username = $motorolauser
                    $password = $motorolapassword
                }
                $Body = "$($formuser)=$($username)&$($formpassword)=$(ConvertFrom-SecureString -SecureString $Password -AsPlainText)"
                Write-Verbose "http://$($ComputerName)$($path)"
                Write-Debug "$Body"
                $Response = Invoke-WebRequest -Method Post -Body $Body -Uri "http://$($ComputerName)$($path)" -SessionVariable WebSession
            } catch {
                Write-Error $_
            }
            $MotorolaWebSession = [psobject]@{
                "ComputerName" = $ComputerName
                "URL" = "http://$($ComputerName)"
                "WebSession" = $WebSession
                "Response" = $Response.StatusCode
            }
            If (!$Script:MotorolaSession) {
                $Script:MotorolaSession = $MotorolaWebSession
            }
            If ($PassThru) {
                $MotorolaSession
            }
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name nmotos -Value New-MotorolaSession