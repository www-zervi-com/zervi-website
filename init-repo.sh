#!/bin/bash

# Zervi Website Repository Initialization Script
# This script helps with initializing a new Git repository for the Zervi website

# Display help message
show_help() {
  echo "Zervi Website Repository Initialization Script"
  echo ""
  echo "Usage: ./init-repo.sh [options]"
  echo ""
  echo "Options:"
  echo "  -h, --help      Show this help message"
  echo "  -o, --org       Specify GitHub organization (default: 'www-zervi-com')"
  echo "  -r, --repo      Specify repository name (default: 'zervi-website')"
  echo ""
  echo "Example:"
  echo "  ./init-repo.sh -o www-zervi-com -r zervi-website"
  echo ""
}

# Default values
ORG="www-zervi-com"
REPO="zervi-website"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h|--help)
      show_help
      exit 0
      ;;
    -o|--org)
      ORG="$2"
      shift
      shift
      ;;
    -r|--repo)
      REPO="$2"
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

# Check if we're already in a git repository
if git rev-parse --is-inside-work-tree &> /dev/null; then
  echo "Error: Already in a git repository. This script is intended for initializing a new repository."
  exit 1
fi

echo "Initializing Git repository for Zervi website..."
echo "Organization: $ORG"
echo "Repository: $REPO"
echo ""

# Initialize git repository
echo "Initializing git repository..."
git init

# Add all files
echo "Adding files..."
git add .

# Create initial commit
echo "Creating initial commit..."
git commit -m "Initial commit"

# Add GitHub remote
echo "Adding GitHub remote..."
git remote add origin "https://github.com/$ORG/$REPO.git"

# Create main branch
echo "Creating main branch..."
git branch -M main

echo ""
echo "Repository initialized successfully!"
echo ""
echo "Next steps:"
echo "1. Create a new repository on GitHub: https://github.com/new"
echo "   - Organization: $ORG"
echo "   - Repository name: $REPO"
echo "   - Make it Public"
echo "   - Do NOT initialize with README, .gitignore, or license"
echo ""
echo "2. Push the repository to GitHub:"
echo "   git push -u origin main"
echo ""
echo "3. GitHub Actions will automatically deploy the website to GitHub Pages."
echo "   You can check the status at: https://github.com/$ORG/$REPO/actions"
echo ""
echo "4. Once deployed, the website will be available at: https://www.zervi.com"
