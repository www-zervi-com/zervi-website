# Zervi Website Setup Guide

This document provides detailed instructions for setting up and deploying the Zervi website project.

## Local Development Setup

### Prerequisites

- [Node.js](https://nodejs.org/) (v14 or higher)
- [npm](https://www.npmjs.com/) (v6 or higher)
- A code editor (VS Code, Sublime Text, etc.)
- Git

### Installation Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/www-zervi-com/zervi-website.git
   cd zervi-website
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Start the development server**

   ```bash
   npm run dev
   ```

   This will start a local development server at http://localhost:3000

4. **Add required image assets**

   - Add the Zervi logo to `images/zervi-logo.png`
   - Add a hero background image to `images/hero-bg.jpg`
   - Add category images to:
     - `images/camping-outdoor.jpg`
     - `images/apparel.jpg`
     - `images/design-studio.jpg`
     - `images/productions-services.jpg`
     - `images/technologies.jpg`
   - Add PWA icons to the `images/icons/` directory (see `images/icons/README.md` for details)

## Deployment

### GitHub Pages Deployment

The project is set up to automatically deploy to GitHub Pages when changes are pushed to the main branch. The GitHub Actions workflow in `.github/workflows/deploy.yml` handles this process.

1. **Push changes to the main branch**

   ```bash
   git add .
   git commit -m "Your commit message"
   git push origin main
   ```

2. **Monitor the deployment**

   - Go to the GitHub repository
   - Click on the "Actions" tab
   - You should see the workflow running
   - Once completed, your site will be available at https://www.zervi-com.github.io/zervi-website/

### Custom Domain Setup

To use a custom domain (e.g., www.zervi.com):

1. **Add a CNAME file**

   Create a file named `CNAME` in the root directory with the following content:

   ```
   www.zervi.com
   ```

2. **Configure DNS settings**

   - Go to your domain registrar's DNS settings
   - Add a CNAME record pointing `www` to `www-zervi-com.github.io`
   - Add an A record pointing the apex domain (`zervi.com`) to GitHub Pages IP addresses:
     - 185.199.108.153
     - 185.199.109.153
     - 185.199.110.153
     - 185.199.111.153

3. **Configure GitHub Pages**

   - Go to the repository settings
   - Navigate to "Pages"
   - Under "Custom domain", enter your domain name
   - Check "Enforce HTTPS" once the certificate is provisioned

## Progressive Web App (PWA)

The website is configured as a Progressive Web App, which allows users to install it on their devices.

### Testing PWA Functionality

1. **Build the project**

   ```bash
   npm run build
   ```

2. **Serve the production build**

   ```bash
   npm start
   ```

3. **Open Chrome and test PWA features**

   - Open Chrome DevTools (F12)
   - Go to the "Application" tab
   - Check "Manifest" and "Service Worker" sections
   - You should see the manifest loaded and the service worker registered

### Lighthouse Audit

Run a Lighthouse audit to check PWA compliance:

1. Open Chrome DevTools
2. Go to the "Lighthouse" tab
3. Select "Progressive Web App" category
4. Click "Generate report"

## Troubleshooting

### Common Issues

1. **Service worker not registering**

   - Check browser console for errors
   - Ensure the service worker path is correct
   - Verify that the service worker file is being served correctly

2. **Images not loading**

   - Check file paths and case sensitivity
   - Verify that image files exist in the correct directories
   - Check browser console for 404 errors

3. **GitHub Pages deployment failing**

   - Check the Actions tab for error details
   - Verify that the workflow file is correctly configured
   - Ensure that GitHub Pages is enabled in repository settings

## Additional Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Progressive Web Apps](https://web.dev/progressive-web-apps/)
- [Service Worker API](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API)
