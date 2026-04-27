# Safety

Splat CLI can inspect data, create payloads, stage trades, sign transactions, submit transactions, manage tokens, and manage delegated grants. Treat those as different risk levels.

## Low Risk

These are generally safe to run for diagnostics or read-only inspection:

```bash
splat --help
splat doctor
splat --json commands
splat auth status
splat me
splat market tokens search SOL
splat portfolio solana-pnl
```

## Requires User Intent

Run only when the user asks for the specific operation:

- Creating, revoking, or updating API tokens.
- Creating OAuth clients or exchanging tokens.
- Preparing, approving, rejecting, or submitting delegated agent trades.
- Creating or changing agent signer grants.
- Building or staging swaps, orders, bridge transactions, or reward claims.

## Requires Explicit Final Confirmation

Do not run final submit/confirm commands unless the user explicitly asks in the current task:

- `splat orders confirm <executionId>`
- `splat solana swap execute ...`
- `splat solana swap submit ...`
- `splat solana swap limit-execute ...`
- `splat solana swap limit-orders cancel ...`
- `splat rewards claim-solana`
- `splat rewards claim-hyperliquid`
- `splat agent trades submit ...`
- `splat auth token revoke ...`
- `splat api-tokens revoke ...`
- any bridge send or withdrawal command

When in doubt, inspect or stage first, show the planned command and expected impact, then wait for explicit instruction.

