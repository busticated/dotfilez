# helper to allow the mklink under PowerShell
function mklink { cmd /c mklink $args }

mklink /H "$HOME\Documents\WindowsPowerShell\profile.ps1" "C:\dev\dotfilez\profile.ps1"
mklink /H "$HOME\Mercurial.ini" "C:\dev\dotfilez\Mercurial.ini"
mklink /H "$HOME\.gitconfig" "C:\dev\dotfilez\gitconfig" #excludes file path needs fixin'