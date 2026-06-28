# Hermes Template Files

These files are placeholders for building your own Hermes Hybrid Agent Router.

Use them as a starting point, not as a blind overwrite of your live Hermes config.

## Files

- `config.yaml` - provider lanes, MOA presets, and routing policy placeholders.
- `profiles/default-SOUL.md` - default router profile role.
- `profiles/researcher/SOUL.md` - evidence/research profile role.
- `profiles/coder/SOUL.md` - implementation/test profile role.
- `profiles/media/SOUL.md` - media workflow profile role.
- `profiles/ops/SOUL.md` - config/gateway/rollback profile role.

## Replace These Placeholders

```text
YOUR_AUTHORITY_PROVIDER
YOUR_AUTHORITY_MODEL
YOUR_AUTHORITY_DISPLAY_NAME
YOUR_LLAMACPP_MODEL
YOUR_OLLAMA_MODEL
```

Example choices:

```text
YOUR_AUTHORITY_PROVIDER=openai-codex
YOUR_AUTHORITY_MODEL=gpt-5.5
YOUR_AUTHORITY_DISPLAY_NAME=OpenAI Codex
YOUR_LLAMACPP_MODEL=your-gguf-model-name
YOUR_OLLAMA_MODEL=your-ollama-model-name
```

## Safe Install Pattern

Use the bootstrap script to stage files first:

```sh
./scripts/bootstrap-hermes-hybrid.sh
```

It writes to `./build/hermes-template/` by default. Review the generated files before copying anything into `~/.hermes`.
