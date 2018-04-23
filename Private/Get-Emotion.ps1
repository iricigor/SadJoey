function Get-Emotion ([string]$URL) {

    # setup
    $Endpoint = 'https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceAttributes=emotion'
   
    # build and invoke request
    $Body = '{"url": "' + $URL + '"}'
    $Headers = @{'Content-Type' = 'application/json'; 'Ocp-Apim-Subscription-Key' = $Key1} # see Read.Me for key info
    $Result = Invoke-WebRequest -Body $Body -Uri $Endpoint -Headers $Headers -Method Post -UseBasicParsing
    
    # return array of emotions
    $ReturnObject = $Result.Content | ConvertFrom-Json
    if ($ReturnObject.faceAttributes.emotion.sadness -is [array]) {
        $ReturnObject = $ReturnObject[0]
        Write-Warning 'More than one person on photo. Using only first one'
    }
    $ReturnObject.faceAttributes.emotion

}