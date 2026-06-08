---
name: splat-cli
description: Use when helping a user operate the Splat CLI for Splat platform auth, market data, portfolio inspection, Solana swaps, Hyperliquid orders, rewards, bridge flows, OAuth/API tokens, or local trade signing setup. This skill teaches agents to inspect the live CLI surface instead of relying on stale command memory.
---

# Splat CLI

Use this skill when the user wants to install, configure, inspect, or automate the `splat` command.

## First Checks

1. Check whether the CLI is installed:

```bash
splat --help
```

2. Check local setup and API reachability:

```bash
splat doctor
```

3. Inspect the current command surface before giving detailed command advice:

```bash
splat --json commands
```

Use `splat help <group>` for group-specific usage, such as `splat help auth`, `splat help orders`, or `splat help solana`.

## References

- Installation: read `references/install.md` when the user needs to install or update the CLI.
- Authentication and environments: read `references/auth.md` before login, staging, local dev, token, OAuth, or API-token work.
- Command catalog: read `references/commands.md` for the generated snapshot, but prefer live `splat --json commands` when available.
- Safety rules: read `references/safety.md` before signing, submitting, swapping, bridging, ordering, claiming rewards, or changing grants.

## Operating Rules

- Prefer JSON output where available when another tool or agent will parse the result.
- Do not invent command flags. Run `splat --json commands` or `splat help <group>` first.
- For authenticated commands, check `splat auth status` and `splat me` before assuming the user is logged in.
- For local signing or submitting flows, make sure the user has run `splat auth login --enable-trading`; use `--dev` or `--staging ... --enable-trading` for those environments.
- For trading or signing flows, prefer quote, inspect, prepare, or execute/stage commands before any final submit/confirm step.
- For normal use, require explicit current-task intent before final submit/confirm actions. If the user wants agentic trading, ask for an explicit autonomous-trading mandate that defines the scope, duration, allowed actions, and approval mode. When that mandate authorizes auto-approval, it counts as current-task intent for Splat-scoped auth, bridge, swap, order, grant, and signer setup needed to trade, provided live inspection and safety gates pass.
- When the user asks for local development URLs, use `splat auth login --dev`. When testing staging, use `--staging` with explicit `--api-url` and `--web-url`.
