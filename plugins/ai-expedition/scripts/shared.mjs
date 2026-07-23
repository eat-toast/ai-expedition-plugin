import { createHash } from "node:crypto";
import { homedir } from "node:os";
import { join } from "node:path";

export const API_ORIGIN = "https://ai-expedition-forge.automl141115.chatgpt.site";
export const PLUGIN_VERSION = "0.1.1";

export function dataDirectory() {
  if (process.env.PLUGIN_DATA) {
    return process.env.PLUGIN_DATA;
  }
  if (process.platform === "win32" && process.env.LOCALAPPDATA) {
    return join(process.env.LOCALAPPDATA, "AI Expedition");
  }
  return join(homedir(), ".ai-expedition");
}

export function safeSessionKey(sessionId) {
  return createHash("sha256").update(sessionId || "unknown-session").digest("hex").slice(0, 24);
}

export async function apiRequest(path, token, body) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), 2500);
  try {
    const response = await fetch(`${API_ORIGIN}${path}`, {
      method: "POST",
      headers: {
        "content-type": "application/json",
        ...(token ? { authorization: `Bearer ${token}` } : {}),
      },
      body: JSON.stringify(body),
      signal: controller.signal,
    });
    const payload = await response.json().catch(() => ({}));
    if (!response.ok) throw new Error(payload.error || `Server returned ${response.status}`);
    return payload;
  } finally {
    clearTimeout(timer);
  }
}
