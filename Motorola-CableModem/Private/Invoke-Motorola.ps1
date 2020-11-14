Function Invoke-Motorola {
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        $MotorolaSession = $Script:MotorolaSession,

        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [String]
        $URI,

        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [String]
        $Method = "Get",

        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [String]
        $Body = ""
    )
    Begin {
        Write-Verbose "Begin $($MyInvocation.MyCommand)"
    }
    Process {
        if ($PSCmdlet.ShouldProcess($MotorolaSession.ComputerName)) {
            try {
                switch ($Method) {
                    "Get" {
                        Write-Verbose "$($MyInvocation.MyCommand): $($MotorolaSession.URL)$URI"
                        $Response = Invoke-WebRequest -Uri "$($MotorolaSession.URL)$URI" -WebSession $MotorolaSession.WebSession
                     }
                    Default {}
                }
                Return $Response
                
            } catch {
                Write-Error $_
            }
        }
    }
    End {
        Write-Verbose "End $($MyInvocation.MyCommand)"
    }
}