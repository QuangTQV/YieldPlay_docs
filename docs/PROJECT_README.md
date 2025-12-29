# YieldPlay SDK Documentation

This is the complete documentation for YieldPlay SDK.

## Setup with GitBook

### Option 1: GitBook.com (Recommended)

1. Push this repo to GitHub
2. Go to [gitbook.com](https://gitbook.com)
3. Create new space "YieldPlay SDK"
4. Connect to GitHub repository
5. Auto-sync enabled ✅

### Option 2: Local Development

```bash
# Install GitBook CLI
npm install -g gitbook-cli

# Initialize
cd yieldplay-docs
gitbook init

# Serve locally
gitbook serve

# Open http://localhost:4000
```

### Option 3: Deploy to Vercel/Netlify

```bash
# Build static site
gitbook build

# Deploy _book folder to Vercel/Netlify
```

## Folder Structure

```
yieldplay-docs/
├── README.md                    # Home page
├── SUMMARY.md                   # Table of contents
├── getting-started/             # Getting started guides
├── core-concepts/               # Core concepts
├── api-reference/              # API documentation
│   ├── users/                  # Users API
│   ├── pools/                  # Pools API
│   ├── transactions/           # Transactions API
│   └── winners/                # Winners API
├── guides/                     # Integration guides
├── examples/                   # Code examples
├── monetization/               # Revenue model
├── security/                   # Security docs
├── faq/                        # FAQ
└── support/                    # Support & changelog
```

## Custom Domain

Set up custom domain in GitBook settings:
```
docs.yieldplay.io
```

## Adding Content

1. Edit markdown files
2. Update SUMMARY.md if adding new pages
3. Commit and push to GitHub
4. GitBook auto-syncs ✅

## Markdown Features

GitBook supports:
- Code blocks with syntax highlighting
- Tabs for multiple language examples
- Callouts/hints
- Embedded videos
- API documentation
- Search

## Next Steps

1. Complete placeholder files in:
   - guides/
   - examples/
   - monetization/
   - security/

2. Add more API endpoints:
   - Create Pool
   - Get Pool
   - Get Leaderboard
   - Get Statistics
   - Get User Info

3. Add integration examples:
   - Unity integration
   - React integration
   - Mobile app integration

4. Add complete code examples
