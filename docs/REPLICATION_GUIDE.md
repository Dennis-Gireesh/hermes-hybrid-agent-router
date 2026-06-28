# Replication Guide

Use this guide to recreate the Hermes hybrid routing pattern with your own models and budget.

This repo is a starter kit. It does not contain private Hermes state, secrets, raw backups, logs, sessions, memories, or account-specific config.

## 1. Choose Your Lanes

Pick lane owners before editing config.

| Lane | Required? | Recommendation |
|---|---:|---|
| Authority | Yes | Use the best model you can access for final decisions, code, config, and tool use |
| Local draft | Yes | Use a fast local model through llama.cpp or Ollama |
| Local reference | Optional | Use a stronger local model for second opinions |
| Experimental | Optional | Add only after canaries prove it is useful |
| MOA aggregator | Optional but useful | Use the authority model as aggregator |

If you have a subscription or hosted model budget, start with the 20 percent target: reserve it for high-consequence tasks and let local lanes handle routine draft work. If you do not have hosted access, run local-only and be stricter about verification.

## 2. Start Local Providers

Ollama:

```sh
ollama serve
ollama pull YOUR_OLLAMA_MODEL
```

llama.cpp:

```sh
llama-server \
  --host 127.0.0.1 \
  --port 8080 \
  --model /path/to/your-model.gguf
```

Confirm both OpenAI-compatible endpoints:

```sh
curl -fsS http://127.0.0.1:11434/v1/models
curl -fsS http://127.0.0.1:8080/v1/models
```

## 3. Stage The Template

Run the non-destructive bootstrap:

```sh
./scripts/bootstrap-hermes-hybrid.sh
```

This creates:

```text
build/hermes-template/
  config.yaml
  SOUL.md
  NEXT_STEPS.md
  profiles/
    researcher/SOUL.md
    coder/SOUL.md
    media/SOUL.md
    ops/SOUL.md
```

Review these files before copying anything into `~/.hermes`.

## 4. Configure Hermes Providers

Use named lanes. Avoid vague aliases when possible.

```yaml
model:
  provider: openai-codex
  default: gpt-5.5

providers:
  llamacpp:
    name: Local llama.cpp
    base_url: http://127.0.0.1:8080/v1
    default_model: your-local-model
    models:
      your-local-model:
        context_length: 65536

  ollama:
    name: Local Ollama
    base_url: http://127.0.0.1:11434/v1
    default_model: YOUR_OLLAMA_MODEL
    models:
      YOUR_OLLAMA_MODEL:
        context_length: 131072

fallback_providers: []
```

The important part is `fallback_providers: []`. Production-sensitive authority work should fail loudly when the authority lane is unavailable.

The full placeholder template lives at [../templates/hermes/config.yaml](../templates/hermes/config.yaml).

## 5. Create Specialist Profiles

Recommended profile split:

```text
default     router, gateway, final synthesis
researcher  evidence, APIs, docs, market research
coder       implementation, tests, review
media       YouTube, transcripts, image/video/audio workflows
ops         Hermes config, gateways, plugins, rollback
```

Each profile should have:

- A clear role in `SOUL.md`.
- The same provider lanes.
- A profile-appropriate MOA default.
- Gateway stopped unless it has its own bot token or channel.
- Verification rules for its job.

Profile role templates live under [../templates/hermes/profiles/](../templates/hermes/profiles/).

## 6. Add MOA Presets

Use MOA only when disagreement is worth paying for.

Example presets:

| Preset | References | Aggregator | Use |
|---|---|---|---|
| `strategy` | authority + local reference | authority | Business, architecture, pricing |
| `coding-review` | authority + llama.cpp | authority | Important code review |
| `local-crosscheck` | llama.cpp + Ollama | authority | Local disagreement before final decision |

## 7. Verify The Setup

Run:

```sh
hermes config check
for p in researcher coder media ops; do hermes --profile "$p" config check; done
hermes profile list
hermes moa list
```

Run canaries:

```sh
hermes -z "Do not use tools. Reply exactly HERMES_DEFAULT_OK"
researcher -z "Do not use tools. Reply exactly RESEARCHER_PROFILE_OK"
coder -z "Do not use tools. Reply exactly CODER_PROFILE_OK"
media -z "Do not use tools. Reply exactly MEDIA_PROFILE_OK"
ops -z "Do not use tools. Reply exactly OPS_PROFILE_OK"
```

Check local lanes directly:

```sh
hermes -m llamacpp:your-local-model -z "Reply exactly HERMES_LLAMACPP_OK"
hermes -m ollama:YOUR_OLLAMA_MODEL -z "Reply exactly HERMES_OLLAMA_OK"
```

## 8. Add Rollback

Before changing live Hermes config:

1. Export or copy the current config.
2. Record the exact files changed.
3. Keep restore commands in the rollout notes.
4. Restart the affected gateway/dashboard only after config checks pass.
5. Rerun canaries after restart.

## 9. Measure Savings

Track at least:

- Number of tasks handled locally.
- Number escalated to authority.
- Number that used MOA.
- Hosted spend per week.
- Failure cases where local output was not good enough.
- Time saved by profile specialization.

Do not guess the savings. Measure your own workload and adjust the routing threshold.
