import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { apiRequest, dataDirectory } from "./shared.mjs";

try {
  const device = JSON.parse(await readFile(join(dataDirectory(), "device.json"), "utf8"));
  if (!device.token) throw new Error("저장된 기기 인증이 없습니다.");

  const result = await apiRequest("/api/devices/status", device.token, {});
  const connection = result.connection;
  const signal = connection.lastExpeditionStatus === "complete"
    ? "시작·완료 신호 정상"
    : connection.lastExpeditionStatus === "running"
      ? "시작 신호 도착 · 완료 대기"
      : "연결됨 · 아직 원정 신호 없음";

  console.log(`AI 원정대: ${signal}`);
  console.log(`이번 주 원정 ${connection.weeklyExpeditions}회 · 최장 ${connection.longestExpeditionSeconds}초 · 누적 ${result.progress.lifetimeExpeditions}회`);
  if (!connection.lastExpeditionStatus) {
    console.log("새 Codex 작업에서도 기록이 없으면 /hooks에서 AI 원정대 훅을 검토하고 신뢰해주세요.");
  }
} catch (error) {
  console.error(`AI 원정대 상태를 확인하지 못했습니다: ${error instanceof Error ? error.message : "알 수 없는 오류"}`);
  process.exit(1);
}
