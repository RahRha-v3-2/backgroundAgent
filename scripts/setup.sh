#!/bin/bash

# Self-Driving Codebase Setup Script
# This script sets up the GitHub repository for AI agent automation

set -e

echo "🤖 Self-Driving Codebase Setup"
echo "==============================="
echo ""

# Check for required tools
echo "📋 Checking requirements..."

if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "   Install from: https://cli.github.com/"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed."
    exit 1
fi

echo "✅ GitHub CLI installed"
echo "✅ Git installed"
echo ""

# Check authentication
echo "🔐 Checking GitHub authentication..."
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub."
    echo "   Run: gh auth login"
    exit 1
fi

echo "✅ Authenticated with GitHub"
echo ""

# Get repository
REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner 2>/dev/null || echo "")
if [ -z "$REPO" ]; then
    echo "⚠️  Not in a GitHub repository."
    echo "   Navigate to your repository root first."
    exit 1
fi

echo "📦 Repository: $REPO"
echo ""

# Setup secrets
echo "🔑 Setting up secrets..."
echo ""

read -p "Enter your Gemini API key (from https://aistudio.google.com/apikey): " API_KEY

if [ -z "$API_KEY" ]; then
    echo "❌ API key is required."
    exit 1
fi

gh secret set GEMINI_API_KEY --body "$API_KEY" --repo "$REPO"
echo "✅ GEMINI_API_KEY set"
echo ""

# Setup variables
echo "⚙️  Setting up variables..."
gh variable set GEMINI_DEBUG --body "false" --repo "$REPO"
echo "✅ GEMINI_DEBUG set to false"
echo ""

# Summary
echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "Your repository is now configured with AI agents."
echo ""
echo "Next steps:"
echo "1. Push these workflows to your repository:"
echo "   git add .github/workflows/"
echo "   git commit -m 'Add AI agent workflows'"
echo "   git push"
echo ""
echo "2. Create an issue with '/implement' to test:"
echo "   @gemini-cli /implement Add a hello world function"
echo ""
echo "3. View agent activity in the Actions tab"
echo ""
