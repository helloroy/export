@ECHO OFF
SET mypath=%~dp0

setlocal EnableDelayedExpansion
FOR /F "skip=1 tokens=1-6" %%A IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
    if "%%B" NEQ "" (
        SET /A FDATE=%%F*10000+%%D*100+%%A
        SET /A FTIME=%%B*10000+%%C*100+%%E
    )
)
SET yyyymmdd=!FDATE!

echo Export Helper v0.1.2 @helloroy 20140219
echo =======================================
echo Export files and folders in : %mypath:~0,-1%
SET /P maxage=Modified date after / equal : (default %yyyymmdd%) 

IF "%maxage%"=="" SET maxage=%yyyymmdd%

set exportpath=export_%maxage%

IF exist %exportpath% ( echo %exportpath% exists ) ELSE ( mkdir %exportpath% )

robocopy %mypath% %exportpath% /maxage:%maxage% /S /XF %mypath:~0,-1%\%~nx0 /XD %mypath:~0,-1%\%exportpath%
