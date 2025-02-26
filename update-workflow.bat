@echo off
echo Updating GitHub Actions workflow...

rem Change to the zervi-website directory
cd /d "C:\Users\Archie\Desktop\Coding Projects\zervi-website"

rem Add the updated workflow file
echo Adding updated workflow file...
git add .github/workflows/deploy.yml

rem Commit the change
echo Committing the change...
git commit -m "Fix: Change npm ci to npm install in workflow"

rem Push to GitHub
echo Pushing to GitHub...
git push origin main

echo.
echo Workflow updated successfully!
echo The GitHub Actions workflow should now run successfully.
echo.

pause
