#!/bin/bash

# Zervi Website Deployment Script
# This script helps with deploying the Zervi website to GitHub Pages

# Display help message
show_help() {
  echo "Zervi Website Deployment Script"
  echo ""
  echo "Usage: ./deploy.sh [options]"
  echo ""
  echo "Options:"
  echo "  -h, --help      Show this help message"
  echo "  -m, --message   Specify commit message (default: 'Update website')"
  echo "  -b, --branch    Specify branch to deploy (default: 'main')"
  echo ""
  echo "Example:"
  echo "  ./deploy.sh -m 'Update contact information' -b main"
  echo ""
}

# Default values
COMMIT_MESSAGE="Update website"
BRANCH="main"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h|--help)
      show_help
      exit 0
      ;;
    -m|--message)
      COMMIT_MESSAGE="$2"
      shift
      shift
      ;;
    -b|--branch)
      BRANCH="$2"
      shift
      shift
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done

# Check if git is installed
if ! command -v git &> /dev/null; then
  echo "Error: git is not installed. Please install git and try again."
  exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
  echo "Error: Not in a git repository. Please run this script from the root of the Zervi website repository."
  exit 1
fi

# Check if the branch exists
if ! git show-ref --verify --quiet refs/heads/$BRANCH; then
  echo "Error: Branch '$BRANCH' does not exist."
  echo "Available branches:"
  git branch
  exit 1
fi

echo "Deploying Zervi website to GitHub Pages..."
echo "Branch: $BRANCH"
echo "Commit message: $COMMIT_MESSAGE"
echo ""

# Make sure we're on the right branch
echo "Checking out branch '$BRANCH'..."
git checkout $BRANCH

# Add all changes
echo "Adding changes..."
git add .

# Commit changes
echo "Committing changes..."
git commit -m "$COMMIT_MESSAGE"

# Push changes
echo "Pushing changes to GitHub..."
git push origin $BRANCH

echo ""
echo "Deployment complete!"
echo "The GitHub Actions workflow should now be running to deploy the website to GitHub Pages."
echo "You can check the status at: https://github.com/www-zervi-com/zervi-website/actions"
echo ""
echo "Once deployed, the website will be available at: https://www.zervi.com"
