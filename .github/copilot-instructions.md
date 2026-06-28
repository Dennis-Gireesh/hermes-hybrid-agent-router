# Repository Instructions

This repository is a public-facing showcase and replication guide for a Hermes hybrid agent setup.

Read these first:

- `README.md`
- `llms.txt`
- `docs/SIMPLE_WORKFLOW.md`
- `docs/ARCHITECTURE.md`
- `docs/REPLICATION_GUIDE.md`
- `templates/hermes/config.yaml`
- `templates/hermes/profiles/`
- `scripts/bootstrap-hermes-hybrid.sh`

Core rules:

- Route by task consequence, not model novelty.
- Use local Ollama and llama.cpp lanes for drafts, summaries, brainstorming, and second opinions.
- Use the authority model for code, config, tool use, production decisions, and money-facing output.
- Use MOA only for high-value review where disagreement is useful.
- Never silently fall back from the authority lane to a weaker local model for production-sensitive work.
- Keep worker gateways stopped unless each worker has a separate bot token or channel.
- Do not add secrets, auth files, tokens, sessions, logs, state databases, raw backups, or personal memories.
- Prefer placeholders and sanitized examples over live Hermes config.

When editing docs, keep the replication path concrete: architecture, configuration, profiles, auxiliary models, MOA, workflows, rollback, verification, and production scope should all be represented.

When editing public-facing text, preserve the main discovery phrase `Hermes Hybrid Agent Router` and use these terms naturally when relevant: Hermes Agent, Ollama, llama.cpp, OpenAI Codex, local LLM router, MOA, mixture of agents, agent workflow, cost optimization, and `llms.txt`.

This public repo should stay a replication starter kit. Do not re-add private rollout notes, SEO launch docs, dated production snapshots, raw backups, memories, sessions, logs, or account-specific config.
