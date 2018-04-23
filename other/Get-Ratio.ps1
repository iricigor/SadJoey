function Get-Ratio ([decimal]$N) {
    if ($N -eq 0) {return 'not'}
    if ($N -eq 1) {return 'the same'}
    
    if ($N -lt 1) {$q = 'less'; $N = 1/$N} 
    else {$q = 'more'}

    if ($N -ge 2) {return "$([int]$N) times $q"}
    else {
        [int]$p = ($N -1)*100
        return "$p percent $q"    
    }
}
