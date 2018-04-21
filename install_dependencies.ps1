#download glfw source and unpack 
#Invoke-WebRequest https://github.com/glfw/glfw/releases/download/3.2.1/glfw-3.2.1.bin.WIN64.zip -Out glfw-3.2.1.bin.WIN64.zip -UseBasicParsing
#Expand-Archive -Path .\glfw3.zip -DestinationPath .

#get current location
$DOCDIR = (Resolve-Path .\).Path



#======================== TAR TOOL =====================================================================
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download latest dotnet/codeformatter release from github
$repo = "senthilrajasek/tartool"
$file = "TarTool.zip"

$releases = "https://api.github.com/repos/$repo/releases"

Write-Host Determining latest release
$tag = (Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$zip = "$name.zip"

Write-Host Dowloading latest release
Invoke-WebRequest $download -Out $zip -UseBasicParsing

Expand-Archive -Path .\$zip -Force -DestinationPath  .\$name
del $zip -Force

#===================================================================================================================



Invoke-WebRequest https://netix.dl.sourceforge.net/project/glew/glew/2.1.0/glew-2.1.0.zip -Out glew-2.1.0.zip -UseBasicParsing

function Resolve-MsBuild {
	$msb2017 = Resolve-Path "${env:ProgramFiles(x86)}\Microsoft Visual Studio\*\*\MSBuild\*\bin\msbuild.exe" -ErrorAction SilentlyContinue
	if($msb2017) {
		Write-Host "Found MSBuild 2017 (or later)."ta
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

#--------- CODE STARTS HERE -------------------------------------------------------

#---------- GET GLFW ------------------------------------------------------------------------
if(!(Test-Path -Path $DOCDIR"/glfw")){
git clone -q https://github.com/glfw/glfw.git
}
else{
  git pull -q
}

cd glfw
if(!(Test-Path -Path $DOCDIR"/glfw/Build")){
    New-Item -ItemType directory -Path $DOCDIR"/glfw/Build"
}
cd Build
cmake ..
#do MsBuild
$msBuild = Resolve-MsBuild
& $msBuild "src/glfw.vcxproj" /verbosity:minimal /p:Configuration=Release /property:Platform=x86

if(!(Test-Path -Path $DOCDIR"/.lib")){
    New-Item -ItemType directory -Path $DOCDIR"/.lib"
}

Copy-Item -Path $DOCDIR"\glfw\Build\src\Release\glfw3.lib" -Destination $DOCDIR"\.lib\glfw3.lib"
#-----------------------------------------------------------------------------------------------


#--------- GET GLEW ----------------------------------------------------------------------------------
cd $DOCDIR
if(!(Test-Path -Path $DOCDIR"\glew")){
Invoke-WebRequest https://netix.dl.sourceforge.net/project/glew/glew/2.1.0/glew-2.1.0.zip -Out glew-2.1.0.zip -UseBasicParsing
Expand-Archive -Path .\glew-2.1.0.zip -Force -DestinationPath  .
del glew-2.1.0.zip -Force
}

cd glew-2.1.0
cd build
cd cmake
if(!(Test-Path -Path $DOCDIR"/glew-2.1.0/build/cmake/build")){
    New-Item -ItemType directory -Path $DOCDIR"/glew-2.1.0/build/cmake/build"
}
cd build
cmake ..

#do MsBuild
$msBuild = Resolve-MsBuild
& $msBuild "glew.sln" /verbosity:minimal /p:Configuration=Release /property:Platform=Win32

if(!(Test-Path -Path $DOCDIR"/bin")){
    New-Item -ItemType directory -Path $DOCDIR"/bin"
}
Copy-Item -Path $DOCDIR"\glew-2.1.0\build\cmake\build\bin\Release\glew32.dll" -Destination $DOCDIR"\bin\glew32.dll"
Copy-Item -Path $DOCDIR"\glew-2.1.0\build\cmake\build\bin\Release\glewinfo.exe" -Destination $DOCDIR"\bin\glewinfo.exe"
if(!(Test-Path -Path $DOCDIR"/.lib")){
    New-Item -ItemType directory -Path $DOCDIR"/.lib"
}
Copy-Item -Path $DOCDIR"\glew-2.1.0\build\cmake\build\lib\Release\libglew32.lib" -Destination $DOCDIR"\.lib\libglew32.lib"
Copy-Item -Path $DOCDIR"\glew-2.1.0\build\cmake\build\lib\Release\glew32.lib" -Destination $DOCDIR"\.lib\glew32.lib"
Copy-Item -Path $DOCDIR"\glew-2.1.0\build\cmake\build\lib\Release\glew32.exp" -Destination $DOCDIR"\.lib\glew32.exp"
#-------------------------------------------------------------------------------------------------------------------

#---------GET FREE GLUT --------------------------------------------------------------------------------------------
cd $DOCDIR
if(!(Test-Path -Path $DOCDIR"\freeglut-3.0.0")){
Invoke-WebRequest https://netix.dl.sourceforge.net/project/freeglut/freeglut/3.0.0/freeglut-3.0.0.tar.gz -Out freeglut-3.0.0.tar.gz -UseBasicParsing

& ".\TarTool\TarTool.exe" ".\freeglut-3.0.0.tar.gz" ./
del freeglut-3.0.0.tar.gz -Force
}
cd $DOCDIR"\freeglut-3.0.0"

if(!(Test-Path -Path $DOCDIR"/freeglut-3.0.0/build")){
    New-Item -ItemType directory -Path $DOCDIR"/freeglut-3.0.0/build"
}
cd build
cmake ..
#do MsBuild
$msBuild = Resolve-MsBuild
& $msBuild "freeglut.vcxproj" /verbosity:minimal /p:Configuration=Release /property:Platform=x86
& $msBuild "freeglut_static.vcxproj" /verbosity:minimal /p:Configuration=Release /property:Platform=x86

if(!(Test-Path -Path $DOCDIR"/bin")){
    New-Item -ItemType directory -Path $DOCDIR"/bin"
}
Copy-Item -Path $DOCDIR"\freeglut-3.0.0\build\bin\Release\freeglut.dll" -Destination $DOCDIR"\bin\freeglut.dll"
if(!(Test-Path -Path $DOCDIR"/.lib")){
    New-Item -ItemType directory -Path $DOCDIR"/.lib"
}
Copy-Item -Path $DOCDIR"\freeglut-3.0.0\build\lib\Release\freeglut.lib" -Destination $DOCDIR"\.lib\freeglut.lib"
Copy-Item -Path $DOCDIR"\freeglut-3.0.0\build\lib\Release\freeglut.exp" -Destination $DOCDIR"\.lib\freeglut.exp"
Copy-Item -Path $DOCDIR"\freeglut-3.0.0\build\lib\Release\freeglut_static.lib" -Destination $DOCDIR"\.lib\freeglut_static.lib"

if(!(Test-Path -Path $DOCDIR"\.include")){
    New-Item -ItemType directory -Path $DOCDIR"\.include"
}
if(!(Test-Path -Path $DOCDIR"/.include/GL")){
    New-Item -ItemType directory -Path $DOCDIR"/.include/GL"
}

Copy-Item -Force -Recurse -Verbose $DOCDIR"\freeglut-3.0.0\include\GL" -Destination $DOCDIR"\.include\"
Copy-Item -Force -Recurse -Verbose $DOCDIR"\glew-2.1.0\include\GL" -Destination $DOCDIR"\.include\"
Copy-Item -Force -Recurse -Verbose $DOCDIR"\glfw\include\GLFW" -Destination $DOCDIR"\.include\"



#----------------------------------------------------------------------------------------------------------------------------------
cd $DOCDIR
Remove-Item -Path $DOCDIR"\freeglut-3.0.0" -Recurse -Force
Remove-Item -Path $DOCDIR"\glew-2.1.0" -Recurse -Force
Remove-Item -Path $DOCDIR"\glfw" -Recurse -Force
Remove-Item -Path $DOCDIR"\TarTool" -Recurse -Force

#src/Release