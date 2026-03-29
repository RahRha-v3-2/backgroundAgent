# Agent System Documentation

This repository uses AI agents powered by Gemini CLI and GitHub Actions to automate various development tasks.

## Overview

The agent system consists of multiple background agents that run in GitHub Actions and respond to different triggers. Each agent is specialized for a specific task.

## Available Agents

### 1. Dispatcher Agent (`gemini-dispatch.yml`)
**Trigger**: Issue comments, PR comments
**Purpose**: Routes requests to the appropriate specialized agent

Commands:
- `/implement` - Implement a feature or fix
- `/review` - Review a pull request
- `/triage` - Classify and triage an issue
- `/doc` - Generate or update documentation
- `/debug` - Diagnose CI/build failures
- `/explain` - Explain code or concepts
- `/help` - Show available commands

### 2. Issue Triage Agent (`scheduled-triage.yml`)
**Trigger**: Scheduled (daily), manual
**Purpose**: Analyzes open issues and provides insights

Tasks:
- Classifies issue types (bug, feature, enhancement, etc.)
- Estimates complexity and priority
- Identifies affected components
- Suggests appropriate labels
- Generates triage reports

### 3. Code Review Agent (`auto-pr-review.yml`)
**Trigger**: PR opened, synchronized, reopened
**Purpose**: Performs automated code reviews

Tasks:
- Analyzes code changes
- Checks for correctness and bugs
- Reviews security implications
- Assesses code quality
- Suggests improvements
- Reviews test coverage

### 4. CI Doctor (`ci-doctor.yml`)
**Trigger**: Workflow run completes with failure, scheduled (nightly)
**Purpose**: Diagnoses CI/CD failures

Tasks:
- Analyzes failure logs
- Identifies root causes
- Suggests fixes
- Creates diagnostic issues
- Provides prevention tips

### 5. Documentation Sync (`documentation-sync.yml`)
**Trigger**: PR merged, manual
**Purpose**: Keeps documentation up-to-date

Tasks:
- Syncs README with code changes
- Generates API documentation
- Creates changelog entries
- Updates relevant docs

### 6. Self-Coding Agent (`self-coding-agent.yml`)
**Trigger**: `/implement` or `/fix` comment, manual
**Purpose**: Implements features and fixes from issues

Tasks:
- Analyzes issue requirements
- Understands codebase structure
- Implements solutions
- Writes tests
- Creates pull requests

### 7. Continuous Improvement (`continuous-improvement.yml`)
**Trigger**: Scheduled (weekly)
**Purpose**: Identifies code improvement opportunities

Tasks:
- Finds code simplification opportunities
- Analyzes test coverage
- Reviews dependencies
- Suggests optimizations

## Usage

### Commenting on Issues/PRs

To trigger an agent, add a comment to an issue or PR:

```
@/implement Fix the login bug where users can't sign in with Google OAuth
```

Available commands:
- `@/implement` - Start implementing a feature
- `@/fix` - Fix a bug
- `@/review` - Get a code review
- `@/triage` - Classify the issue
- `@/doc` - Generate documentation
- `@/debug` - Diagnose CI failure
- `@/explain` - Get code explanation

### Manual Triggers

Go to the **Actions** tab in GitHub and manually trigger workflows.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Events                            │
│  (Issues, PRs, Comments, Workflow Runs, Schedules)         │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                   Dispatcher Agent                          │
│         (Routes to appropriate agent)                       │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌──────────┬──────────┼──────────┬──────────┐
        ▼          ▼          ▼          ▼          ▼
   ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
   │ Triage │ │ Review │ │  Doc   │ │ Debug  │ │Implement│
   └────────┘ └────────┘ └────────┘ └────────┘ └────────┘
        │          │          │          │          │
        └──────────┴──────────┴──────────┴──────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Actions                            │
│            (Create Issues, PRs, Comments)                    │
└─────────────────────────────────────────────────────────────┘
```

## Security

- Agents run with minimal permissions (read-only by default)
- Write operations require explicit approval
- API keys stored as encrypted secrets
- Agents cannot access external services without configuration
- All operations logged and auditable

## Rate Limits

Using the **free tier**:
- Gemini API: 10 requests/minute, 250 requests/day
- GitHub Actions: 2,000 minutes/month

Optimizations:
- Use `gemini-2.5-flash-lite` for simple tasks
- Batch similar operations
- Use schedules to spread load

## Configuration

### Required Secrets
- `GEMINI_API_KEY` - Your Gemini API key from Google AI Studio

### Optional Variables
- `GEMINI_DEBUG` - Enable debug logging (true/false)

## Extending the System

To add a new agent:

1. Create a new workflow file in `.github/workflows/`
2. Define the trigger events
3. Implement the agent logic using `google-github-actions/run-gemini-cli`
4. Add the command to the dispatcher if it should be triggered by comments
5. Update this documentation

## Best Practices

1. **Start Small** - Begin with simple, low-risk tasks
2. **Review Outputs** - Always review agent suggestions before merging
3. **Provide Context** - Detailed issues get better results
4. **Monitor Usage** - Watch for rate limit issues
5. **Iterate** - Refine prompts based on results

## Troubleshooting

### Agent Not Responding
- Check if the workflow ran in the Actions tab
- Verify `GEMINI_API_KEY` secret is set
- Check for rate limit errors

### Poor Results
- Be more specific in issue descriptions
- Provide examples in the issue
- Update `GEMINI.md` with better guidelines

### Rate Limit Errors
- Use `gemini-2.5-flash-lite` for simple tasks
- Reduce workflow frequency
- Consider batching operations

## Contributing

This is an open project. Contributions welcome:
- Improve agent prompts
- Add new capabilities
- Fix bugs
- Improve documentation
