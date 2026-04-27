# Auth And Environments

## Production Login

```bash
splat auth login
splat auth status
splat me
```

`splat auth` is an alias for the default production login flow.

## Local Development

Use the development platform targets:

```bash
splat auth login --dev
splat doctor
```

Use `--enable-trading` only when the user explicitly wants delegated trading credential setup:

```bash
splat auth login --dev --enable-trading
```

## Staging

Always pass explicit staging targets:

```bash
splat auth login --staging \
  --api-url https://api.staging.asksplat.com \
  --web-url https://terminal.staging.asksplat.com
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

