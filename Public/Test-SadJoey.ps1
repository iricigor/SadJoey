function Test-SadJoey {

    param (
        [string]$URL,
        [string]$Name,
        [switch]$Full,
        
        [ValidateSet('string','HTML','InvokeHTML')]
        [string]$Response = 'string'
    )

    $JoeyScores = @{
        "anger" = 0.00301013677;
        "contempt" = 0.00139871461;
        "disgust" = 0.000218930392;
        "fear" = 0.0001952641;
        "happiness" = 2.49271034E-05;
        "neutral" = 0.9844196;
        "sadness" = 0.00958818849;
        "surprise" = 0.00114422885
      }

      $EmotionsMap = @{
        "anger" = 'angry';
        "contempt" = 'despised';
        "disgust" = 'disgusted';
        "fear" = 'afraid';
        "happiness" = 'happy';
        "neutral" = 'neutral';
        "sadness" = 'sad';
        "surprise" = 'surprised'
      }

    try {
        $Emotions = Get-Emotion $URL
    } catch {
        if ($Key1) {throw "Error while reading emotions: $_"}
        else {throw "Please re-import module with -Force and setup application key"}
    }

    $Greeting = if ($Name) {"Hi $Name"} else {'Hello'}

    if (!$Full) {
        $Comparison = Get-Comparison ($Emotions.sadness / $JoeyScores.sadness) 'sad' 'Joey'
        $ReturnValue = "$Greeting, you are $Comparison."
    } else {
        # iterate all
        $ReturnValue = @("$Greeting, here is your emotions report:")
        foreach ($E in $JoeyScores.Keys) {$ReturnValue += Get-Comparison ($Emotions.$E / $JoeyScores.$E) $EmotionsMap.$E 'Joey'}
    }

    if ($Response -ne 'string') {
        $PreContent = "<table><tr><td><img src='$URL'></td><td><img src='https://i.imgflip.com/28monq.jpg'</td></tr></table>"
        # PowerShell cannot handle single column properly
        $ReturnValue = $ReturnValue | % { [pscustomobject]@{name=$_} } | ConvertTo-Html -Title 'Sad Joey test' -PreContent $PreContent
        $ReturnValue = $ReturnValue | % {if ($_ -notin @('<tr><th>*</th></tr>','<colgroup><col/></colgroup>')) {$_}} 
    }

    if ($Response -ne 'InvokeHTML') {
        $ReturnValue
    } else {
        $TempFile = Join-Path ($env:TEMP) ((Get-Random).ToString()+'.html')
        $ReturnValue | Out-File $TempFile -Encoding utf8
        Invoke-Item $TempFile
    }
}

Set-Alias -Name tsj -Value Test-SadJoey