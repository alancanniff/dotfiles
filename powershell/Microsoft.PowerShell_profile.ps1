
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-Alias -Name vim -Value "nvim"
$env:DISPLAY = "localhost:0.0"
