$scriptblock = @"
##region <Initialise> ================================================================
#   ## DIGITAL GUARDIAN #######################################################      
#   ########:::######::: ######::::::: ########: ########:::: ###:::: ##:::: ##
#   ##.... ##: ##... ##: ##... ##:::::... ##..:: ##.....:::: ## ##::: ###:: ###
#   ##:::: ##: ##:::..:: ##:::..::::::::: ##:::: ##:::::::: ##:. ##:: ####'####
#   ########::. ######:: ##:: ####::::::: ##:::: ######:::'##:::. ##: ## ### ##
#   ##.....::::..... ##: ##::: ##:::::::: ##:::: ##...:::: #########: ##. #: ##
#   ##::::::::'##::: ##: ##::: ##:::::::: ##:::: ##::::::: ##.... ##: ##:.:: ##
#   ##::::::::. ######::. ######::::::::: ##:::: ########: ##:::: ##: ##:::: ##
#   ##::::::::.:::::::::: Robot Framework Installer © 2021                   ##
#   ## AUTHOR: dbaldree@digitalguardian.com :::::::::::::::::::::::::::::::::##
#   ##:##############################################################  v 1.0 ##
#   ##   RUNNING DEPLOYMENT TASK: STEP 2                                     ##
#   ###########################################################################
##End region <Initialise> ============================================================
"@
Write-Host $scriptblock -ForegroundColor yellow  

Write-Host "`r`nSetting up::: Robot Framework components and finishing off deployment...`r`n" -for cyan

## Deploy Python27
Write-Host "Deploying Python 2.7 Interpretor..." -for cyan
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi" -OutFile "C:\deploy\python-2.7.13.x86.msi"
$ArgumentList = "/i c:\deploy\python-2.7.13.x86.msi ALLUSERS=1 ADDLOCAL=ALL /qn"
$ExitCode = (Start-Process -FilePath "MsiExec.exe" -ArgumentList $ArgumentList -Wait -PassThru).ExitCode
if($ExitCode -eq 0){Write-Host "Success: Code=$ExitCode" -for green}else{Write-Host "Failed: Code=$ExitCode" -for red}

##update pip
Write-Host "Updating pip..." -for cyan
&c:\python27\python -m pip install --upgrade pip

#Deploy Python 2.7 ArgParse Mod
Write-Host "Deploying Python 2.7 ArgParse mod..." -for cyan
&C:\Python27\Scripts\pip.exe install argparse
Write-Host "Success: Code=0" -for green

#Deploy Python 2.7 PyWin32 Mod
Write-Host "Deploying Python 2.7 PyWin32 mod..." -for cyan
&C:\Python27\Scripts\pip.exe install pywin32==223
Write-Host "Success: Code=0" -for green

#AutoIT3
Write-Host "Deploying AutoIt3..." -for cyan
Invoke-WebRequest -Uri "https://www.autoitscript.com/cgi-bin/getfile.pl?autoit3/autoit-v3-setup.exe" -OutFile "C:\deploy\autoit-v3-setup.exe"
$ArgumentList = "/S"
$ExitCode = (Start-Process -FilePath "c:\deploy\autoit-v3-setup.exe" -ArgumentList $ArgumentList -Wait -PassThru).ExitCode
if($ExitCode -eq 0){Write-Host "Success: Code=$ExitCode" -for green}else{Write-Host "Failed: Code=$ExitCode" -for red}

#AutoIt Library 1.1
Write-Host "Deploying AutoIt Library 1.1. from Google..." -for cyan
Invoke-WebRequest -Uri "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/robotframework-autoitlibrary/AutoItLibrary-1.1.zip" -OutFile "C:\deploy\AutoItLibrary-1.1.zip"
Expand-Archive -LiteralPath "C:\deploy\AutoItLibrary-1.1.zip" -DestinationPath "$Env:SYSTEMDRIVE\"
#Setup AutoIt Library 1.1
&cmd.exe /c "cd $Env:SYSTEMDRIVE\AutoItLibrary-1.1\ & c:\python27\python.exe `"$Env:SYSTEMDRIVE\AutoItLibrary-1.1\setup.py`" install"
Write-Host "Success: Code=0" -for green

#ROBOT FRAMEWORK
##install robotframework & selenium library
Write-Host "Deploying robotframework & selenium library..." -for cyan
&C:\Python27\Scripts\pip.exe install robotframework-remoterunner
&C:\Python27\Scripts\pip.exe install robotframework==3.1.1
&C:\Python27\Scripts\pip.exe install wheel
&C:\Python27\Scripts\pip.exe install wxPython==4.1.0
&C:\Python27\Scripts\pip.exe install robotframework==3.1.1
&C:\Python27\Scripts\pip.exe install robotframework-archivelibrary==0.4.0
&C:\Python27\Scripts\pip.exe install robotframework-autoitlibrary==1.1.0
&C:\Python27\Scripts\pip.exe install decorator
&C:\Python27\Scripts\pip.exe install robotframework-selenium2library==1.8.0
&C:\Python27\Scripts\pip.exe install pyodbc
&C:\Python27\Scripts\pip.exe install jdcal
&C:\Python27\Scripts\pip.exe install et-xmlfile
&C:\Python27\Scripts\pip.exe install openpyxl
&C:\Python27\Scripts\pip.exe install xlwt
&C:\Python27\Scripts\pip.exe install xlrd
&C:\Python27\Scripts\pip.exe install xlutils
&C:\Python27\Scripts\pip.exe install checksumdir
&C:\Python27\Scripts\pip.exe install xlwings
&C:\Python27\Scripts\pip.exe install psutil
&C:\Python27\Scripts\pip.exe install setuptools
&C:\Python27\Scripts\pip.exe install pathlib
&C:\Python27\Scripts\pip.exe install scandir

Write-Host "[COMPLETED DEPLOYMENT]: Sleeping for 60 seconds before final reboot..." -for green