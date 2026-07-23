---
name: connect-ai-expedition
description: Connect this Codex installation to an AI Expedition account when the user provides a six-character pairing code or asks to connect AI Expedition.
---

# Connect AI Expedition

Use this skill only to connect the installed plugin to the user's AI Expedition account.

1. Ask for the six-character code if the user did not provide it.
2. Run `node "$PLUGIN_ROOT/scripts/pair.mjs" CODE`, replacing `CODE` with the supplied code. On Windows PowerShell, run `powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$env:PLUGIN_ROOT\scripts\pair.ps1" CODE`.
3. Report the script's result exactly enough for the user to know whether the connection succeeded.

Never print or inspect the saved device token. The pairing code is single-use and expires after ten minutes.
