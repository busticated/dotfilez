#================================================================================#
# PowerShell Profile - C:\Users\mmirande\Documents\WindowsPowerShell\profile.ps1 #
#================================================================================#

# Globals =======================================================================#
$PROFILE = $HOME + "\Documents\WindowsPowerShell\profile.ps1"
$NODEMODULES = $HOME + "\AppData\Roaming\npm\node_modules"
$DROPBOX = $HOME + "\Documents\My Dropbox"
$DEV = "C:\dev"
$CHZ = $DEV + "\chzbrgr\chzbrgr.com"
$CHZMIRANDE = $DEV + "\chzbrgr\ChzMirande"

# Imports =======================================================================#
import-module $DEV\dotfilez\powershell\utils.psm1

# Startup =======================================================================#
Set-ExecutionPolicy RemoteSigned #run local scripts only, assumes running as admin
Set-Location $DEV
Set-EnvPath @(
	"C:\Program Files\Windows Azure SDK\v1.0\bin",
	"C:\Program Files (x86)\nodejs",
	"C:\Program Files (x86)\Python27",
	"C:\Ruby193\bin",
	"C:\Program Files (x86)\Git\bin",
	"C:\Program Files (x86)\Vim\vim73",
	"C:\Ruby193\bin",
	"C:\ctags58",
	"$HOME\AppData\Local\Google\Chrome\Application\"
)
function prompt{
	$user = $env:username
	$location = Get-Location
	$date = Get-Date -format "ddd.MMM.dd.yyyy..HH:mm:ss"
	"$user.........$date..........($location)`n>>"
}
$env:editor = "notepad"
Set-AnimatedMsg @( " (-_-)", " (°_°)", " ~(°o°)~", " \(°u°)/" ) 300

# Aliases =======================================================================#
#Set-Alias example-alias "C:\path\to\some\thing.ext"

# Funcs =========================================================================#
function cd-dropbox { cd $DROPBOX }
function cd-dev { cd $DEV }
function cd-chz { cd $CHZ }
function edit-hgrc { notepad "$HOME\Mercurial.ini" }
function edit-profile { notepad $PROFILE }
function hg-latest($count){
	if( ! $count ){
		$count = 5
	}
	hg log --limit $count
}
function rjs($buildFile) { node "$NODEMODULES\requirejs\bin\r.js" -o $buildFile }
