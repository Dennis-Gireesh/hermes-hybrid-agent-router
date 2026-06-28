#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
OUT_DIR="${1:-"$ROOT_DIR/build/hermes-template"}"

mkdir -p "$OUT_DIR/profiles/researcher" "$OUT_DIR/profiles/coder" "$OUT_DIR/profiles/media" "$OUT_DIR/profiles/ops"

cp "$ROOT_DIR/templates/hermes/config.yaml" "$OUT_DIR/config.yaml"
cp "$ROOT_DIR/templates/hermes/profiles/default-SOUL.md" "$OUT_DIR/SOUL.md"
cp "$ROOT_DIR/templates/hermes/profiles/researcher/SOUL.md" "$OUT_DIR/profiles/researcher/SOUL.md"
cp "$ROOT_DIR/templates/hermes/profiles/coder/SOUL.md" "$OUT_DIR/profiles/coder/SOUL.md"
cp "$ROOT_DIR/templates/hermes/profiles/media/SOUL.md" "$OUT_DIR/profiles/media/SOUL.md"
cp "$ROOT_DIR/templates/hermes/profiles/ops/SOUL.md" "$OUT_DIR/profiles/ops/SOUL.md"

cat > "$OUT_DIR/NEXT_STEPS.md" <<'EOF'
# Next Steps

1. Replace all YOUR_* placeholders in config.yaml.
2. Compare config.yaml with your existing Hermes config.
3. Copy only the reviewed sections into your live Hermes config.
4. Copy SOUL.md and profile SOUL.md files into the matching Hermes profile homes if you want these roles.
5. Run:

```sh
hermes config check
for p in researcher coder media ops; do hermes --profile "$p" config check; done
hermes moa list
curl -fsS http://127.0.0.1:8080/v1/models
curl -fsS http://127.0.0.1:11434/v1/models
```

Do not copy secrets, auth files, sessions, logs, memories, or raw backups into git.
EOF

printf 'Hermes hybrid template staged at: %s\n' "$OUT_DIR"
printf 'Review NEXT_STEPS.md before copying anything into ~/.hermes.\n'
