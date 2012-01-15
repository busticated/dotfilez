#================================================================================#
# PowerShell Profile - C:\Users\mmirande\Documents\WindowsPowerShell\profile.ps1 #
#================================================================================#

# Globals =======================================================================#
$PROFILE = $HOME + "\Documents\WindowsPowerShell\profile.ps1"
$NODEMODULES = $HOME + "\AppData\Roaming\npm\node_modules"
$DROPBOX = $HOME + "\Documents\My Dropbox"
$DEV = "C:\dev"
$CHZ = $DEV + "\chzbrgr\ChzClean"
$CHZMIRANDE = $DEV + "\chzbrgr\ChzMirande"

# Imports =======================================================================#
import-module $DEV\dotfilez\powershell\utils.psm1

# Startup =======================================================================#
Set-ExecutionPolicy RemoteSigned #run local scripts only, assumes running as admin
Set-Location $DEV
function prompt{
	$user = $env:username
	$location = Get-Location
	$date = Get-Date -format "ddd.MMM.dd.yyyy..HH:mm:ss"
	"$user.........$date..........($location)`n>>"
}
$env:editor = "notepad"
Set-AnimatedMsg @( " (-_-)", " (°_°)", " ~(°o°)~", " \(°u°)/" ) 300
Set-EnvPath @(
	"C:\Program Files\Windows Azure SDK\v1.6\bin",
	"C:\Program Files (x86)\nodejs",
	"C:\Program Files (x86)\Python27",
	"C:\Ruby193\bin",
	"C:\Program Files (x86)\Git\bin",
	"C:\Program Files (x86)\Vim\vim73",
	"C:\ctags58",
	"$HOME\AppData\Local\Google\Chrome\Application\"
)

# Aliases =======================================================================#
Set-Alias installutil (join-path (& Get-FrameworkDirectory) "installutil.exe")
Set-Alias msbuild (join-path (& Get-FrameworkDirectory) "msbuild.exe")

# Helper Funcs ==================================================================#
function cd-dropbox { cd $DROPBOX }
function cd-dev { cd $DEV }
function cd-chz { cd $CHZ }
function cd-chzmirande { cd $CHZMIRANDE }
function edit-hgrc { notepad "$HOME\Mercurial.ini" }
function edit-profile { notepad $PROFILE }
function hg-latest( $count ){
	if( ! $count ){
		$count = 5
	}
	hg log --limit $count
}
function Build-JS( $buildFile ) { node "$NODEMODULES\requirejs\bin\r.js" -o $buildFile }

#bah... msbuild does this already by default... might be more helpful to optionally
#build all or some of the individual projects
function Build-Chz( $buildDir ){
	if ( -not ( test-path "$buildDir\Mine.sln" ) ) {
		write-host "Invalid project file - $buildDir does not exist";
		return
	}
	msbuild "$buildDir\Mine.sln"
}
