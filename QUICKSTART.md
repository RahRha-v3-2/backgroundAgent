# Quick Start Guide

## Your API Key Status
✅ **Gemini API is working** (tested successfully)

⚠️ **SECURITY WARNING**: Your API key was exposed in a chat. **Rotate it now!**

## Immediate Actions

### 1. Rotate API Key
```
https://aistudio.google.com/apikey
```
Delete old key → Create new key

### 2. Set Secret in GitHub
```bash
gh secret set GEMINI_API_KEY --body "NEW_KEY_HERE"
```

### 3. Run Quick Test
1. Go to **Actions** tab
2. Select **Test Agent System**
3. Click **Run workflow**
4. Choose **quick** → Run

## Available Test Options

| Test | What it does |
|------|--------------|
| `quick` | Tests API key works |
| `full` | Tests Gemini CLI integration |
| `triage` | Creates a test issue, triages it, closes it |
| `review` | Tests code review on sample code |

## After Testing - Try Real Commands

Once tests pass, try on any issue:

```comment
@gemini-cli /triage
```

Or create an issue with:
```comment
@gemini-cli /implement Add a simple hello world function that prints "Hello, World!"
```

## Verify Rate Limits

Your free tier includes:
- **10 requests/minute**
- **250 requests/day**
- **1M token context**

Check usage at: https://aistudio.google.com/capabilities

## Files Created

```
self-driving-codebase/
├── .github/workflows/
│   ├── gemini-dispatch.yml      # Main command router
│   ├── test-agent.yml          # Test suite (you ran this)
│   ├── auto-pr-review.yml      # Auto-review PRs
│   ├── ci-doctor.yml           # Debug CI failures
│   ├── scheduled-triage.yml    # Daily issue triage
│   ├── documentation-sync.yml  # Update docs
│   └── self-coding-agent.yml   # Implement features
├── GEMINI.md                   # Agent guidelines
├── AGENTS.md                   # Full documentation
└── README.md                   # Overview
```

## Next Steps

1. ✅ Run quick test to confirm setup
2. ✅ Run triage test to see automation in action
3. 🎯 Create a real issue and try `/implement`
4. 🔧 Customize `GEMINI.md` for your codebase
