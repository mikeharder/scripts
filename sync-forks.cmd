@echo off
setlocal enabledelayedexpansion

for /f "delims=" %%i in (%~dp0\sync-forks.txt) do (
    start /b gh repo sync mikeharder/%%i
)

endlocal
