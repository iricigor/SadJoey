function Test-SadJoey {

    param (
        [string]$URL,
        [string]$Name,
        [switch]$Full,
        
        [ValidateSet('string','HTML','InvokeHTML')]
        [string]$Response = 'string'
    )

    $JoeyScores = @{
        "anger" = 0.0112354308;
        "contempt" = 0.00654790876;
        "disgust" = 0.0008751894;
        "fear" = 0.000156739319;
        "happiness" = 1.14264813E-05;
        "neutral" = 0.920633435;
        "sadness" = 0.0599093549;
        "surprise" = 0.00063054
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
        if (!$Emotions) {throw 'No faces detected'}
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
        $Title = 'Sad Joey Test'
        $JoeyURL = 'http://bit.ly/SJ-SadJoey'
        $PreContent = "<table><tr><td><img src='$URL' style=`"max-width:320px;`"></td><td><img src='$JoeyURL'</td></tr></table>"
        $PostContent = "<a href=`"https://sadjoey.azurewebsites.net/api/SJ`">Go Back</a>"
        # PowerShell cannot handle single column properly
        $ReturnValue = $ReturnValue | % { [pscustomobject]@{name=$_} } | ConvertTo-Html -Title $Title -PreContent $PreContent -PostContent $PostContent
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