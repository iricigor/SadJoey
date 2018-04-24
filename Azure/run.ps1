# Import files
cd $EXECUTION_CONTEXT_FUNCTIONDIRECTORY
. .\Get-Emotion.ps1
. .\Get-Comparison.ps1
. .\Test-SadJoey.ps1
$Key1 = Get-Content .\key.txt # this file cannot be shared


# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$name = $requestBody.name
$url = $requestBody.url

# GET method: each querystring parameter is its own variable
if ($req_query_url) 
{
    $name = $req_query_name 
    $url = $req_query_url
}

if (!$url) {
    'show default web page'
    $Output = Get-Content .\index.html -Raw
} else {
    'call comparison'
    $Output = (Test-SadJoey -URL $url -Name $Name -Response HTML) -join "`n"
}

$Output2 = [string]::Format('{{ "Status": 200, "Body": "{0}", "Headers": {{"content-type": "text/html" }} }}', $Output -replace '"',"'")
Out-File -Encoding utf8 -FilePath $res -inputObject $Output2
