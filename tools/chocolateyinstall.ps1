﻿$packageId = 'OpenSSL'
 
#default is to plop in c:\ -- yuck!
$installDir = Join-Path $Env:ProgramFiles 'OpenSSL'
 
$params = @{
  packageName = $packageId;
  fileType = 'exe';
  #InnoSetup - http://unattended.sourceforge.net/InnoSetup_Switches_ExitCodes.html
  silentArgs = '/silent', '/verysilent', '/sp-', '/suppressmsgboxes',
    "/DIR=`"$installDir`"";
  url = 'https://slproweb.com/download/Win32OpenSSL-1_1_1a.exe'
  url64bit = 'https://slproweb.com/download/Win64OpenSSL-1_1_1a.exe'
}
 
Install-ChocolateyPackage @params
 
if (!$Env:OPENSSL_CONF)
{
  $configPath = Join-Path $installDir 'bin\openssl.cfg'
 
  if (Test-Path $configPath)
  {
    [Environment]::SetEnvironmentVariable(
      'OPENSSL_CONF', $configPath, 'User')
 
    Write-Output "Configured OPENSSL_CONF variable as $configPath"
  }
}
