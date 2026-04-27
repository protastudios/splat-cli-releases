# Install

## Public Installer

Use the public release installer:

```bash
curl -fsSL https://raw.githubusercontent.com/protastudios/splat-cli-releases/main/install-release.sh | bash
```

Useful overrides:

```bash
SPLAT_INSTALL_DIR="$HOME/.local/bin" \
SPLAT_INSTALL_VERSION="v1.0.67" \
curl -fsSL https://raw.githubusercontent.com/protastudios/splat-cli-releases/main/install-release.sh | bash
```

## Homebrew

```bash
brew install protastudios/tap/splat
```

Use `brew upgrade splat` to update.

## Verify

```bash
splat --help
splat doctor
splat --json commands
```

## npm

The package identity is `@splat/cli`, but the preferred public install path is currently the release installer or Homebrew because those install standalone release assets. If npm support is offered in a given release, verify it with:

```bash
npm install -g @splat/cli
splat --help
```

