@echo off
setlocal

REM Set the source directory to the current folder
set "src_dir=%cd%"
set "dest_dir=%src_dir%\_src"

REM Check if ImageMagick's "magick" command is available
where magick >nul 2>nul
if errorlevel 1 (
    echo ImageMagick is not installed or not in PATH.
    pause
    exit /b
)

REM Create the destination folder if it does not exist
if not exist "%dest_dir%" (
    mkdir "%dest_dir%"
)

REM Convert each jpg and png file to webp
for %%f in (*.jpg *.png) do (
    echo Converting "%%f" to webp...
    magick "%%f" "%%~nf.webp"

    REM Move the original file to the _src folder
    if exist "%%~nf.webp" (
        move "%%f" "%dest_dir%"
    )
)

echo All files have been converted and moved.
pause
