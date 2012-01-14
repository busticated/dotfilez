#=============================================================================#
# Windows Environment Setup
# ============================================================================#

# helper to allow the mklink under PowerShell
function mklink { cmd /c mklink $args }

mklink /H "$HOME\Documents\WindowsPowerShell\profile.ps1" "C:\dev\dotfilez\profile.ps1"
mklink /H "$HOME\Mercurial.ini" "C:\dev\dotfilez\Mercurial.ini"
mklink /H "$HOME\.gitconfig" "C:\dev\dotfilez\gitconfig-windows"
mklink /H "$HOME\.gitignore_global" "C:\dev\dotfilez\gitignore_global"
mklink /H "$HOME\.vimrc" "C:\dev\dotfilez\vimrc"
mklink /H "$HOME\.gvimrc" "C:\dev\dotfilez\gvimrc"
if (!(Test-Path -path "$HOME\.vim")) {
   New-Item "$HOME\.vim" -type directory
   New-Item "$HOME\.vim\backup" -type directory
}
