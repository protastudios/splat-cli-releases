# Splat CLI Releases

This repo hosts the public release assets for the Splat CLI.

## Purpose

The source code for the CLI and backend remains private in:

- `protastudios/splat-trading-backend`

This repo is public so installers and Homebrew can fetch release assets without needing access to the private source repository.

## Install

The installer script lives in the source repo and downloads assets from this public repo:

```bash
curl -fsSL https://raw.githubusercontent.com/protastudios/splat-trading-backend/main/scripts/install-release.sh | bash
```

## Homebrew

The Homebrew formula in `protastudios/homebrew-tap` points at the GitHub releases published here.

Target install command:

```bash
brew install protastudios/tap/splat
```

## Contents

Tagged releases in this repo are expected to include:

- macOS tarballs
- Linux tarballs
- Windows zip archives
- `checksums.txt`

The backend release workflow publishes those assets here automatically when distribution secrets are configured.
