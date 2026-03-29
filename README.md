# Self-Driving Codebase

A GitHub repository that drives itself using AI agents powered by Gemini CLI and GitHub Actions. This project implements a system of autonomous agents that can triage issues, review code, update documentation, diagnose CI failures, and even implement features from issue descriptions.

## Features

- **Issue Triage** - Automatically classifies and prioritizes new issues
- **Code Review** - Reviews pull requests with AI-powered analysis
- **CI Doctor** - Diagnoses CI/CD failures and suggests fixes
- **Documentation Sync** - Keeps README and docs updated with code changes
- **Self-Coding Agent** - Implements features from issue descriptions
- **Continuous Improvement** - Weekly analysis for code simplification opportunities

## Quick Start

### 1. Set Up API Key

Get your Gemini API key from [Google AI Studio](https://aistudio.google.com/apikey):

1. Go to [Google AI Studio](https://aistudio.google.com/apikey)
2. Click "Create API Key"
3. Copy the key

### 2. Add Secret to GitHub

1. Go to your repository **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Name: `GEMINI_API_KEY`
4. Value: Paste your API key
5. Click **Add secret**

### 3. Enable Actions

The workflows are already configured. Just push to your repository and they will activate.

## Available Commands

Comment on any issue or PR to trigger agents:

| Command | Description | Example |
|---------|-------------|---------|
| `/implement` | Implement a feature from issue | `@gemini-cli /implement Add dark mode support` |
| `/fix` | Fix a bug from issue | `@gemini-cli /fix Users can't log in with Safari` |
| `/review` | Review a pull request | `@gemini-cli /review` |
| `/triage` | Classify an issue | `@gemini-cli /triage` |
| `/doc` | Generate documentation | `@gemini-cli /doc Update API docs` |
| `/debug` | Diagnose CI failure | `@gemini-cli /debug Build is failing` |
| `/explain` | Explain code | `@gemini-cli /explain this function` |
| `/help` | Show available commands | `@gemini-cli /help` |

## How It Works

```
You create an issue
        │
        ▼
┌───────────────────┐
│  GitHub Actions   │
│    triggers       │
└───────────────────┘
        │
        ▼
┌───────────────────┐
│  Gemini CLI       │
│  processes request│
└───────────────────┘
        │
        ▼
┌───────────────────┐
│  Creates PR/      │
│  Comments/Issues  │
└───────────────────┘
```

## Free Tier Limits

### Gemini API (Free)
- **Requests**: 10/minute, 250/day
- **Tokens**: 250,000/minute
- **Context**: 1 million tokens

### GitHub Actions (Free)
- **Minutes**: 2,000/month
- **Concurrency**: 20 jobs
- **Storage**: 500 MB

## Workflows

### Dispatcher (`gemini-dispatch.yml`)
Central routing for all agent commands. Runs on issue/PR comments.

### Issue Triage (`scheduled-triage.yml`)
Daily analysis of open issues. Runs at 8 AM UTC.

### Auto PR Review (`auto-pr-review.yml`)
Automatic code review on PR creation.

### CI Doctor (`ci-doctor.yml`)
Diagnoses failed CI runs. Also runs nightly health checks.

### Documentation Sync (`documentation-sync.yml`)
Updates docs when code changes. Runs on PR merge.

### Self-Coding Agent (`self-coding-agent.yml`)
Implements features from issues. Triggered by `/implement` command.

### Continuous Improvement (`continuous-improvement.yml`)
Weekly code analysis. Runs every Monday at 3 AM UTC.

## Configuration

### GEMINI.md
Edit this file to customize agent behavior for your codebase.

### Workflow Settings
In GitHub Actions, you can set these variables:
- `GEMINI_DEBUG` - Enable debug logging (set to `true`)

## Customization

### Adding New Commands
Edit `gemini-dispatch.yml` to add new commands:

```yaml
# In the dispatch job
if echo "$COMMENT" | grep -q "/your-command"; then
  echo "command=your-command" >> $GITHUB_OUTPUT
fi
```

### Custom Agents
Create new workflow files following the existing patterns.

## Security

- API keys stored as GitHub secrets
- Agents run with minimal permissions
- All operations logged
- No external service access without configuration

## Troubleshooting

### Agent not responding?
1. Check the Actions tab for errors
2. Verify `GEMINI_API_KEY` is set
3. Check for rate limit messages

### Rate limit errors?
- Reduce workflow frequency
- Use simpler prompts
- Consider batching operations

### Poor results?
- Be more specific in descriptions
- Add examples to issues
- Update `GEMINI.md` with better context

## Contributing

Contributions welcome! Areas for improvement:
- Better prompts
- New agent capabilities
- Bug fixes
- Documentation improvements

## License

MIT

## Resources

- [Gemini CLI Documentation](https://github.com/google-gemini/gemini-cli)
- [GitHub Actions](https://docs.github.com/actions)
- [Google AI Studio](https://aistudio.google.com)
# Test
