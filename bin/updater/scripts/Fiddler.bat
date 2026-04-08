@ECHO OFF
SET "TOOL_NAME=%~1"
SET "UNPACK_DIR=%~2"
SET "DOWNLOAD_VER=%~3"
SET "BIN_DIR=%UNPACK_DIR%\..\..\bin"

echo Extracting NSIS installer
cd /d "%UNPACK_DIR%"
for %%F in (FiddlerSetup.*.exe) do (
    "%BIN_DIR%\7z.exe" x -y -bso0 "%%F" -o"%UNPACK_DIR%"
)

echo Extracting Fiddler from inner setup
"%BIN_DIR%\7z.exe" x -y -bso0 "%UNPACK_DIR%\$PLUGINSDIR\FiddlerSetup.exe" -o"%UNPACK_DIR%"

echo Cleaning NSIS leftovers
for %%F in ("%UNPACK_DIR%\FiddlerSetup.*.exe") do (
    del /f /q "%%F"
)
for /d %%D in ("%UNPACK_DIR%\$*") do (
    rmdir /s /q "%%D"
)

echo Moving Script Editor
if not exist "%UNPACK_DIR%\ScriptEditor" mkdir "%UNPACK_DIR%\ScriptEditor"
move /y "%UNPACK_DIR%\FSE2.exe" "%UNPACK_DIR%\ScriptEditor\"
