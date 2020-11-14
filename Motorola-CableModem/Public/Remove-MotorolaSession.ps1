Function Remove-MotorolaSession {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        $MotorolaSession = $Script:MotorolaSession
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
        $path = "/logout.asp"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($MotorolaSession.ComputerName)) {
            try {
                $Response = Invoke-Motorola -MotorolaSession $MotorolaSession -URI $path
            } catch {
                Write-Error $_
            }
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}
Set-Alias -Name rmotos -Value Remove-MotorolaSession