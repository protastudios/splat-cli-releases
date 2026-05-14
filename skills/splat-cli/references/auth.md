# Auth And Environments

## Production Login

```bash
splat auth login
splat auth status
splat me
```

`splat auth` is an alias for the default production login flow.

When the user wants the CLI to sign or submit swaps, confirm staged orders, cancel signed orders, or claim rewards, request local trade/swap signing access:

```bash
splat auth login --enable-trading
```

The browser approval page should show `Trading delegation: Requested`. Without `--enable-trading`, the CLI can authenticate for read/API workflows but local signing commands will not have the Turnkey CLI credential they need.

## Local Development

Use the development platform targets:

```bash
splat auth login --dev
splat doctor
```

Use `--enable-trading` only when the user explicitly wants local trade/swap signing setup:

```bash
splat auth login --dev --enable-trading
```

## Staging

Always pass explicit staging targets:

```bash
splat auth login --staging \
  --api-url https://api.staging.asksplat.com \
  --web-url https://terminal.staging.asksplat.com

splat auth login --staging \
  --api-url https://api.staging.asksplat.com \
  --web-url https://terminal.staging.asksplat.com \
  --enable-trading
```

## Existing Tokens

Save an existing platform token:

```bash
splat auth save <token> [apiUrl]
```

Manage personal API tokens:

```bash
splat auth token list
splat auth token create "Local Agent" profile:read,market-data:read
splat auth token revoke <apiTokenId>
```

## OAuth

OAuth commands exist for client management and token exchange. Inspect current usage first:

```bash
splat help oauth
splat --json commands
```
