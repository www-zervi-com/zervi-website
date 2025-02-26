@echo off
:: Zervi Website Repository Initialization Script for Windows
:: This script helps with initializing a new Git repository for the Zervi website

setlocal enabledelayedexpansion

:: Default values
set ORG=www-zervi-com
set REPO=zervi-website

:: Parse command line arguments
:parse_args
if "%~1"=="" goto :end_parse_args
if "%~1"=="-h" goto :show_help
if "%~1"=="--help" goto :show_help
if "%~1"=="-o" (
    set ORG=%~2
    shift
    shift
    goto :parse_args
)
if "%~1"=="--org" (
    set ORG=%~2
    shift
    shift
    goto :parse_args
)
if "%~1"=="-r" (
    set REPO=%~2
    shift
    shift
    goto :parse_args
)
if "%~1"=="--repo" (
    set REPO=%~2
    shift
    shift
    goto :parse_args
)
echo Unknown option: %~1
goto :show_help

:end_parse_args

:: Check if git is installed
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Error: git is not installed. Please install git and try again.
    exit /b 1
)

:: Check if we're already in a git repository
git rev-parse --is-inside-work-tree >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo Error: Already in a git repository. This script is intended for initializing a new repository.
    exit /b 1
)

echo Initializing Git repository for Zervi website...
echo Organization: %ORG%
echo Repository: %REPO%
echo.

:: Initialize git repository
echo Initializing git repository...
git init

:: Add all files
echo Adding files...
git add .

:: Create initial commit
echo Creating initial commit...
git commit -m "Initial commit"

:: Add GitHub remote
echo Adding GitHub remote...
git remote add origin "https://github.com/%ORG%/%REPO%.git"

:: Create main branch
echo Creating main branch...
git branch -M main

echo.
echo Repository initialized successfully!
echo.
echo Next steps:
echo 1. Create a new repository on GitHub: https://github.com/new
echo    - Organization: %ORG%
echo    - Repository name: %REPO%
echo    - Make it Public
echo    - Do NOT initialize with README, .gitignore, or license
echo.
echo 2. Push the repository to GitHub:
echo    git push -u origin main
echo.
echo 3. GitHub Actions will automatically deploy the website to GitHub Pages.
echo    You can check the status at: https://github.com/%ORG%/%REPO%/actions
echo.
echo 4. Once deployed, the website will be available at: https://www.zervi.com
goto :eof

:show_help
echo Zervi Website Repository Initialization Script for Windows
echo.
echo Usage: init-repo.bat [options]
echo.
echo Options:
echo   -h, --help      Show this help message
echo   -o, --org       Specify GitHub organization (default: 'www-zervi-com')
echo   -r, --repo      Specify repository name (default: 'zervi-website')
echo.
echo Example:
echo   init-repo.bat -o www-zervi-com -r zervi-website
echo.
exit /b 0
