
$root = 'http://localhost:7071/api'

# 1
iwr -Method GET -Uri $root/HttpTriggerCSharp?Name=Davide

iwr -Method POST `
-Uri $root/HttpTriggerCSharp?Name=Davide `
-Headers @{"Content-Type"="application/json"} `
-Body '{}'

# 2
iwr -Method GET -Uri $root/HttpTriggerCSharp2?Name=Davide

iwr -Method POST `
-Uri $root/HttpTriggerCSharp2?Name=Davide `
-Headers @{"Content-Type"="application/json"} `
-Body '{}'