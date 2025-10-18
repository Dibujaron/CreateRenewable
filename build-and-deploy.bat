@echo off
REM Build and deploy CreateRenewable mod to test instance

echo Building mod...
call "%~dp0gradlew.bat" build
if %ERRORLEVEL% NEQ 0 (
    echo Build failed!
    exit /b %ERRORLEVEL%
)

echo Build successful!
echo Copying to mods folder...

set TARGET_DIR=C:\Users\dibuj\curseforge\minecraft\Instances\GC Evergreen\mods
set JAR_FILE=build\libs\createrenewable-0.1.0.jar

REM Remove old versions of the mod
del "%TARGET_DIR%\createrenewable-*.jar" 2>nul

REM Copy new version
copy "%JAR_FILE%" "%TARGET_DIR%\"
if %ERRORLEVEL% NEQ 0 (
    echo Copy failed!
    exit /b %ERRORLEVEL%
)

echo Successfully deployed to: %TARGET_DIR%
echo Done!
