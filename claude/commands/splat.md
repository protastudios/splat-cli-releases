---
description: Inspect and use the Splat CLI safely
argument-hint: [task]
---

Use the Splat CLI to help with this task:

`$ARGUMENTS`

Before giving detailed command advice, inspect the installed CLI when possible:

```bash
splat --json commands
```

Also check setup when the task involves auth, API reachability, trading, signing, or local environments:

```bash
splat doctor
splat auth status
```

Follow these rules:

- Do not invent flags or command names. Use the live command catalog or `splat help <group>`.
- Prefer read-only inspection before writes, signing, trading, token changes, or grant changes.
- Do not run final submit, confirm, revoke, claim, bridge, or signing commands unless the user explicitly asks for that final action.
