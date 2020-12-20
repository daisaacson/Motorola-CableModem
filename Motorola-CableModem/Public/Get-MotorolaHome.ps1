Function Get-MotorolaHome {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        $MotorolaSession = $Script:MotorolaSession
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "MotoHome"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ComputerName)) {
            $Response = Invoke-Motorola -MotorolaSession $MotorolaSession -Uri $motorolaURIs.$path
            Return $Response
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name gmotoHome -Value Get-MotorolaHome