@echo off
:: Zervi Website Deployment Script for Windows
:: This script helps with deploying the Zervi website to GitHub Pages

setlocal enabledelayedexpansion

:: Default values
set COMMIT_MESSAGE=Update website
set BRANCH=main

:: Parse command line arguments
:parse_args
if "%~1"=="" goto :end_parse_args
if "%~1"=="-h" goto :show_help
if "%~1"=="--help" goto :show_help
if "%~1"=="-m" (
    set COMMIT_MESSAGE=%~2
    shift
    shift
    goto :parse_args
)
if "%~1"=="--message" (
    set COMMIT_MESSAGE=%~2
    shift
    shift
    goto :parse_args
)
if "%~1"=="-b" (
    set BRANCH=%~2
    shift
    shift
    goto :parse_args
)
if "%~1"=="--branch" (
    set BRANCH=%~2
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

:: Check if we're in a git repository
git rev-parse --is-inside-work-tree >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Error: Not in a git repository. Please run this script from the root of the Zervi website repository.
    exit /b 1
)

:: Check if the branch exists
git show-ref --verify --quiet refs/heads/%BRANCH%
if %ERRORLEVEL% neq 0 (
    echo Error: Branch '%BRANCH%' does not exist.
    echo Available branches:
    git branch
    exit /b 1
)

echo Deploying Zervi website to GitHub Pages...
echo Branch: %BRANCH%
echo Commit message: %COMMIT_MESSAGE%
echo.

:: Make sure we're on the right branch
echo Checking out branch '%BRANCH%'...
git checkout %BRANCH%

:: Add all changes
echo Adding changes...
git add .

:: Commit changes
echo Committing changes...
git commit -m "%COMMIT_MESSAGE%"

:: Push changes
echo Pushing changes to GitHub...
git push origin %BRANCH%

echo.
echo Deployment complete!
echo The GitHub Actions workflow should now be running to deploy the website to GitHub Pages.
echo You can check the status at: https://github.com/www-zervi-com/zervi-website/actions
echo.
echo Once deployed, the website will be available at: https://www.zervi.com
goto :eof

:show_help
echo Zervi Website Deployment Script for Windows
echo.
echo Usage: deploy.bat [options]
echo.
echo Options:
echo   -h, --help      Show this help message
echo   -m, --message   Specify commit message (default: 'Update website')
echo   -b, --branch    Specify branch to deploy (default: 'main')
echo.
echo Example:
echo   deploy.bat -m "Update contact information" -b main
echo.
exit /b 0
