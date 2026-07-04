# SSH Client Configuration

Proxies all non-local connections through `localhost:7890`.

## Contents

| File | Purpose |
|------|---------|
| `config` | SSH client configuration |

## Configuration

```
Host !*.local *
    ProxyCommand nc -Xconnect -x localhost:7890 %h %p
```

Local addresses (`.local` domain) bypass the proxy.

## Conventions

- `private_` prefix in source state triggers restrictive permissions on target (700 dirs, 600 files)
- Never commit actual private keys — they should be generated per-machine
- Selectively deployed via `.chezmoiignore` template — only when `data.personal = true` in `chezmoi.toml`
