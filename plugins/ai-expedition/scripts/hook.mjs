import { randomUUID } from "node:crypto";
import { mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { apiRequest, dataDirectory, PLUGIN_VERSION, safeSessionKey } from "./shared.mjs";

async function readStdin() {
  let raw = "";
  for await (const chunk of process.stdin) raw += chunk;
  try {
    return JSON.parse(raw || "{}");
  } catch {
    return {};
  }
}

async function main() {
  const action = process.argv[2];
  if (action !== "start" && action !== "complete") return;

  const event = await readStdin();
  const directory = dataDirectory();
  const sessionKey = safeSessionKey(String(event.session_id || "unknown-session"));
  const statePath = join(directory, `active-${sessionKey}.json`);
  const devicePath = join(directory, "device.json");

  let device;
  try {
    device = JSON.parse(await readFile(devicePath, "utf8"));
  } catch {
    return;
  }
  if (!device.token) return;

  await mkdir(directory, { recursive: true });
  if (action === "start") {
    const state = { turnId: randomUUID(), sessionKey, startedAt: new Date().toISOString() };
    await apiRequest("/api/expeditions/start", device.token, {
      turnId: state.turnId,
      pluginVersion: PLUGIN_VERSION,
    });
    await writeFile(statePath, JSON.stringify(state), "utf8");
    return;
  }

  let state;
  try {
    state = JSON.parse(await readFile(statePath, "utf8"));
  } catch {
    return;
  }
  await apiRequest("/api/expeditions/complete", device.token, { turnId: state.turnId });
  await rm(statePath, { force: true });
}

main().catch(() => {
  // The game must never interrupt the user's Codex work.
  process.exitCode = 0;
});
