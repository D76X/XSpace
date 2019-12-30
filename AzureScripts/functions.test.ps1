. .\functions.ps1

# test
Write-Output 'tests for functions.ps1'

# test 1
Write-Output 'test1'
$test1 = $false
Wait-Condition -Condition {$test1 -eq $true}

# test 1
Write-Output 'test2'
$test1 = $false
Wait-Condition -Condition {$test1 -eq $true} -CheckEvery 2 -Timeout 5 -Message '**wainting**'
