# AI Expedition — AI maintainer guide

This file is written for coding agents. Read it before changing this repository.

## Product intent

AI Expedition turns normal Codex work into a lightweight shared game. One Codex turn becomes one expedition. Completed expeditions contribute to progression and weekly friend rankings.

The game must stay secondary to the user's real work:

- Never interrupt or delay Codex work because the game server is unavailable.
- Never send prompt text, response text, file contents, file paths, or tool output.
- Never print, inspect, commit, or ask the user to paste a saved device token.
- Prefer a small, understandable implementation over additional background behavior.

## Repository layout

- `.agents/plugins/marketplace.json`: marketplace entry discovered after the repository is added to Codex.
- `plugins/ai-expedition/.codex-plugin/plugin.json`: plugin identity, version, and UI metadata.
- `plugins/ai-expedition/hooks/hooks.json`: starts an expedition on `UserPromptSubmit` and completes it on `Stop`.
- `plugins/ai-expedition/scripts/shared.mjs`: API origin, version, storage path, and HTTP helper.
- `plugins/ai-expedition/scripts/hook.mjs`: macOS/Linux Node hook implementation.
- `plugins/ai-expedition/scripts/hook.ps1`: Windows PowerShell hook implementation.
- `plugins/ai-expedition/scripts/pair.mjs` and `pair.ps1`: exchange a six-character one-time code for a device token.
- `plugins/ai-expedition/skills/connect/SKILL.md`: tells Codex how to perform pairing safely.
- `plugins/ai-expedition/scripts/status.mjs` and `status.ps1`: report sanitized connection and expedition counters.
- `plugins/ai-expedition/skills/status/SKILL.md`: tells Codex how to diagnose ranking signals without exposing tokens.
- `README.md`: human-facing installation instructions.
- `SECURITY.md`: secret-handling guidance.

## Runtime contract

Pairing:

1. The user signs in at the AI Expedition website.
2. The website issues a single-use six-character code that expires after ten minutes.
3. A pairing script sends the code to `/api/devices/pair`.
4. The returned device token is stored locally in `device.json`.

Expeditions:

1. `UserPromptSubmit` creates a random `turnId` and calls `/api/expeditions/start`.
2. The active turn is stored locally using a hash of the Codex session ID.
3. `Stop` calls `/api/expeditions/complete` with the same `turnId`.
4. Any network or game error is swallowed so Codex work continues.

The server, not the client, is authoritative for rewards and rankings.

## Privacy and security invariants

Treat these as release blockers:

- Hook input may be used only to derive a non-reversible local session key.
- Do not include raw session IDs in API requests.
- Do not transmit prompts, answers, file data, paths, repository names, or tool results.
- Keep API requests on HTTPS and retain short timeouts.
- Pairing codes are single-use and short-lived.
- Device tokens must remain in the user's local application-data directory.
- Examples and logs must never contain real codes or tokens.

## Change rules

When behavior changes:

1. Keep Node and PowerShell implementations equivalent.
2. Update the version in `plugin.json`, `shared.mjs`, and all PowerShell scripts that send the version together.
3. Update `CHANGELOG.md` and user-facing instructions when installation or pairing changes.
4. Do not change the marketplace name `ai-expedition-friends` or plugin name `ai-expedition` without a migration plan.
5. Do not add a new data field to an API request unless its privacy need is documented.

## Validation before release

Run the plugin validator and syntax checks:

```text
python <plugin-creator>/scripts/validate_plugin.py plugins/ai-expedition
node --check plugins/ai-expedition/scripts/shared.mjs
node --check plugins/ai-expedition/scripts/hook.mjs
node --check plugins/ai-expedition/scripts/pair.mjs
node --check plugins/ai-expedition/scripts/status.mjs
```

Also parse all `.ps1` files with the PowerShell parser and verify `.agents/plugins/marketplace.json` as JSON.

For a release, commit to `main` only after validation and create a matching semantic version tag such as `v0.1.1`.

## Definition of done

A change is complete only when:

- Codex work still succeeds when the game API is offline.
- Node and PowerShell behavior match.
- No prohibited user content is transmitted.
- Installation and pairing instructions remain accurate.
- The plugin validator and syntax checks pass.
