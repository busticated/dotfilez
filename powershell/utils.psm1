#================================================================================#
# PowerShell Utils Module
#================================================================================#

# allow the mklink under PowerShell
function mklink { cmd /c mklink $args }

# open file explorer in this directory
function exp([string] $loc = '.') {
	explorer "/e,"$loc""
}

# open this file in chrome
function chrome([string] $loc = 'index.html') {
	$loc = (Resolve-Path $loc).path
	chrome.exe "$loc"
}

# update path - thanks frank!
function Set-EnvPath{
	param ( $paths )

	if ( $paths -is [system.string] ){
		$paths = @( $paths )
	}

	ForEach( $p in $paths ){
		if ( -not ( test-path $p ) ) {
			write-host "Invalid PATH reference found during setup - skipping : $p";
			continue
		}
		[System.Environment]::SetEnvironmentVariable( "PATH", $env:Path + ";" + $p, "Process" )
	}
}

function Get-IPs() {
	$ent = [net.dns]::GetHostEntry([net.dns]::GetHostName())
	return $ent.AddressList | ?{ $_.ScopeId -ne 0 } | %{
		[string]$_
	}
}

function Get-EscapedHTML([string] $text) {
	$text = $text.Replace('&', '&amp;')
	$text = $text.Replace('"', '&quot;')
	$text = $text.Replace('<', '&lt;')
	$text.Replace('>', '&gt;')
}

function Set-AnimatedMsg( $frames, $rate = 50 ){
	clear
	ForEach( $f in $frames ){
		Write-Host $f
		Start-Sleep -m $rate
		clear
	}
}

Export-ModuleMember -Function *