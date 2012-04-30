#================================================================================#
# PowerShell Profile - C:\Users\mmirande\Documents\WindowsPowerShell\profile.ps1 #
#================================================================================#

# Globals =======================================================================#
$PROFILE = $HOME + "\Documents\WindowsPowerShell\profile.ps1"
$NODEMODULES = $HOME + "\AppData\Roaming\npm\node_modules"
$DROPBOX = $HOME + "\Documents\My Dropbox"
$DEV = "C:\dev"
$CHZ = $DEV + "\chzbrgr\"
$CHZMIRANDE = $DEV + "\chzbrgr\ChzMirande"
$CHZHIPSTERS = $DEV + "\chzbrgr\ChzHipsters"

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
	"$HOME\AppData\Local\Google\Chrome\Application\",
	"C:\Program Files (x86)\NUnit 2.5.10\bin\net-2.0\"
)

# Aliases =======================================================================#
Set-Alias installutil (join-path (& Get-FrameworkDirectory) "installutil.exe")
Set-Alias msbuild (join-path (& Get-FrameworkDirectory) "msbuild.exe")
Set-Alias npp "C:\Program Files (x86)\Notepad++\notepad++.exe"

# Helper Funcs ==================================================================#
function cd-dropbox { cd $DROPBOX }
function cd-dev { cd $DEV }
function cd-chz { cd $CHZ }
function cd-chzMirande { cd $CHZMIRANDE }
function cd-chzHipsters { cd $CHZHIPSTERS }
function edit-hgrc { npp "$HOME\Mercurial.ini" }
function edit-profile { npp $PROFILE }
function hg-latest( $count ){
	if( ! $count ){
		$count = 5
	}
	hg log --limit $count
}

function Habanero( $projDir ) {
	if ( -not ( test-path "$CHZ\$projDir" ) ) {
		write-host "Invalid project directory - $projDir does not exist";
		return
	}
	#todo - parse my habanero config to change the "mineCodebase" setting
	cd "$CHZ\Habanero"
	& .\RunAll.ps1 .\Configs\mirande.ps1
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
