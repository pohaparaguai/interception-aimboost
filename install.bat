@echo off
cd /d "%~dp0"

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

resources\install-interception.exe /install
copy /Y "resources\interception.dll" "%SystemRoot%\System32" >nul

if not exist "%SystemRoot%\System32\drivers\keyboard.sys" (
    copy /Y "resources\keyboard.sys" "%SystemRoot%\System32\drivers" >nul
)

if not exist "%SystemRoot%\System32\drivers\mouse.sys" (
    copy /Y "resources\mouse.sys" "%SystemRoot%\System32\drivers" >nul
)

exit /b