function Get-Comparison ([decimal]$N,[string]$E,[string]$J) {
    if ($N -eq 0) {return "not $E at all"}
    if ($N -lt 1.005 -and $N -gt 0.995) {return "the same $E as $J"}

    if ($N -lt 1) {$q = 'less'; $N = 1/$N} else {$q = 'more'}

    if ($N -ge 2) {return "$([int]$N) times $q $e than $J"}
    else {
        [int]$p = ($N -1)*100
        return "$p percent $q $E than $J"    
    }

}