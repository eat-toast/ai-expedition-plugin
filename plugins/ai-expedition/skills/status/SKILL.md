---
name: check-ai-expedition-status
description: Check whether this Codex installation is connected to AI Expedition and whether start and completion signals are reaching the server.
---

# Check AI Expedition Status

Use this skill when the user asks whether AI Expedition is connected, why an expedition is missing from rankings, or requests a connection diagnostic.

1. Run `node "$PLUGIN_ROOT/scripts/status.mjs"`.
2. On Windows PowerShell, run `powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$env:PLUGIN_ROOT\scripts\status.ps1"`.
3. Report the connection state, this week's expedition count, and the suggested next action.

Never print, inspect, or ask the user to share `device.json` or its token. If the plugin is connected but has no expedition signal, tell the user to open `/hooks`, review the AI Expedition hook, trust it, and then start a new Codex turn.
