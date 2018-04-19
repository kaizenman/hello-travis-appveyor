[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download latest dotnet/codeformatter release from github
$repo = "makolyan/hello-world"
$file = "run_windows.exe"

$releases = "https://api.github.com/repos/$repo/releases"

Write-Host Determining latest release
$tag = (Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$exe = "bin\$name.exe"

Write-Host Dowloading latest release
Invoke-WebRequest $download -Out $exe -UseBasicParsing