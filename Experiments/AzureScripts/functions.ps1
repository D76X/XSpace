Function Wait-Condition {
    [OutputType('void')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [scriptblock]$Condition,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]$CheckEvery = 1, ## seconds

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]$Timeout = 10, ## seconds

		[Parameter()]        
        [string]$Message = '...' ## seconds
    )  

    try 
	{
		$timer = [Diagnostics.Stopwatch]::StartNew()					 
		$timeoutReached = $false
		while (-not (& $Condition) -and ($timeoutReached -eq $false)) 
		{
		Write-Output $Message
		Start-Sleep -Seconds $CheckEvery
		if($timer.Elapsed.TotalSeconds -ge $Timeout) { $timeoutReached = $true }
		}
		$timer.stop()
    }
	finally 
	{
        ## When finished, stop the timer
        $timer.Stop()
    }
}