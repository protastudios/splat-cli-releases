# Splat CLI Releases

This repo hosts the public release assets for the Splat CLI.

## Purpose

The source code for the CLI and backend remains private in:

- `protastudios/splat-trading-backend`

This repo is public so installers and Homebrew can fetch release assets without needing access to the private source repository.

## Install

The installer script lives in this public repo and downloads release assets from this public repo:

```bash
curl -fsSL https://raw.githubusercontent.com/protastudios/splat-cli-releases/main/install-release.sh | bash
```

## Homebrew

The Homebrew formula in `protastudios/homebrew-tap` points at the GitHub releases published here.

Target install command:

```bash
brew install protastudios/tap/splat
```

## Agent Skills

This repo also publishes agent-facing guidance for the Splat CLI:

- Codex skill: `skills/splat-cli/SKILL.md`
- Claude Code command: `claude/commands/splat.md`
- Claude Code memory snippet: `claude/CLAUDE.md.snippet`

The Codex skill teaches agents to inspect the live CLI surface with `splat --json commands` and to use staged/explicit confirmation flows for trading, signing, bridge, reward, token, and grant operations.

Install both Codex and Claude Code guidance with npm:

```bash
npx @splat/agent-skills install
```

Install only one target:

```bash
npx @splat/agent-skills install --codex
npx @splat/agent-skills install --claude
```

After installation, restart Codex or Claude Code so the new skill or command is discovered.

The no-npm fallback is:

```bash
curl -fsSL https://raw.githubusercontent.com/protastudios/splat-cli-releases/main/install-agent-skills.sh | bash
```

Fallback install for only one target:

```bash
curl -fsSL https://raw.githubusercontent.com/protastudios/splat-cli-releases/main/install-agent-skills.sh | SPLAT_INSTALL_CLAUDE=0 bash
curl -fsSL https://raw.githubusercontent.com/protastudios/splat-cli-releases/main/install-agent-skills.sh | SPLAT_INSTALL_CODEX=0 bash
```

Publish the npm installer after logging into an npm account with access to the `@splat` scope:

```bash
npm test
npm pack --dry-run
npm publish --access public
```

## Contents

Tagged releases in this repo are expected to include:

- macOS tarballs
- Linux tarballs
- Windows zip archives
- `checksums.txt`

The backend release workflow publishes those assets here automatically when distribution secrets are configured.
