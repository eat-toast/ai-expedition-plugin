import { mkdir, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { apiRequest, dataDirectory, PLUGIN_VERSION } from "./shared.mjs";

const code = String(process.argv[2] || "").trim().toUpperCase();
if (!/^[2-9A-HJ-NP-Z]{6}$/.test(code)) {
  console.error("연결 코드 6자리를 입력해주세요.");
  process.exit(1);
}

try {
  const result = await apiRequest("/api/devices/pair", "", {
    code,
    label: `${process.platform} Codex`,
    pluginVersion: PLUGIN_VERSION,
  });
  const directory = dataDirectory();
  await mkdir(directory, { recursive: true });
  await writeFile(join(directory, "device.json"), JSON.stringify({
    deviceId: result.deviceId,
    token: result.token,
    connectedAt: new Date().toISOString(),
  }), { encoding: "utf8", mode: 0o600 });
  console.log("AI 원정대 연결이 완료되었습니다. 다음 Codex 작업부터 랭킹에 반영됩니다.");
} catch (error) {
  console.error(`연결하지 못했습니다: ${error instanceof Error ? error.message : "알 수 없는 오류"}`);
  process.exit(1);
}
