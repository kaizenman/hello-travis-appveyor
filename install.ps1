#get current location
$DOCDIR = (Resolve-Path .\).Path

function Resolve-MsBuild {
	$msb2017 = Resolve-Path "${env:ProgramFiles(x86)}\Microsoft Visual Studio\*\*\MSBuild\*\bin\msbuild.exe" -ErrorAction SilentlyContinue
	if($msb2017) {
		Write-Host "Found MSBuild 2017 (or later)."
		Write-Host $msb2017
		return $msb2017
	}

	$msBuild2015 = "${env:ProgramFiles(x86)}\MSBuild\14.0\bin\msbuild.exe"

	if(-not (Test-Path $msBuild2015)) {
		throw 'Could not find MSBuild 2015 or later.'
	}

	Write-Host "Found MSBuild 2015."
	Write-Host $msBuild2015

	return $msBuild2015
}

#generate sln project for VS
if(!(Test-Path -Path 'Build')){
    New-Item -ItemType directory -Path 'Build'
}
cd Build
Write-Host "Preparing build..."
cmake ..
Write-Host "Making binaries..."

#do MsBuild
$msBuild = Resolve-MsBuild
& $msBuild "hello_world.sln" /verbosity:minimal /p:Configuration=Release

if(!(Test-Path -Path $DOCDIR"/bin")){
    New-Item -ItemType directory -Path $DOCDIR"/bin"
}

#copy binary
Copy-Item -Path $DOCDIR"\Build\bin\Release\run_windows.exe" -Destination $DOCDIR"\bin\run_windows.exe"

#delete Buld directory
Write-Host "Deleting Build directory"

Remove-Item -Path $DOCDIR"\Build" -Recurse -Force

cd $DOCDIR

#launch updater
#echo "Launching Updater..."

#& ((Split-Path $MyInvocation.InvocationName) + "\updater.ps1")
Write-Host "Done"