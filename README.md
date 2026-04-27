# Splat CLI Releases

Public GitHub release artifacts for the Splat CLI.

Latest expected install path:

```bash
curl -fsSL https://raw.githubusercontent.com/protastudios/splat-cli-releases/main/install-release.sh | bash
```

This repo hosts the public release assets consumed by:

- the Splat installer script
- the Homebrew formula in `protastudios/homebrew-tap`

## Agent Skills

This repo also publishes agent-facing guidance for the Splat CLI:

- Codex skill: `skills/splat-cli/SKILL.md`
- Claude Code command: `claude/commands/splat.md`
- Claude Code memory snippet: `claude/CLAUDE.md.snippet`

The Codex skill teaches agents to inspect the live CLI surface with `splat --json commands` and to use staged/explicit confirmation flows for trading, signing, bridge, reward, and token operations.

Install both Codex and Claude Code guidance with npm:

```bash
npx @asksplat/agent-skills install
```

Install only one target:

```bash
npx @asksplat/agent-skills install --codex
npx @asksplat/agent-skills install --claude
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

Publish the npm installer after logging into an npm account with access to the `@asksplat` scope:

```bash
npm test
npm_config_cache=/tmp/asksplat-agent-skills-npm-cache npm pack --dry-run
npm_config_cache=/tmp/asksplat-agent-skills-npm-cache npm publish --access public
```
