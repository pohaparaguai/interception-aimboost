@echo off
cd /d "%~dp0"

:: Verificar privilégios administrativos e solicitar elevação se necessário
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

:: Executar o desinstalador da pasta resources
resources\install-interception.exe /uninstall

:: Remover DLL de System32
if exist "%SystemRoot%\System32\interception.dll" (
    del /F /Q "%SystemRoot%\System32\interception.dll"
)