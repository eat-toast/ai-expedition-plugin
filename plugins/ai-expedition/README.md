# AI Expedition Codex plugin

Codex 작업 한 번을 AI 원정대의 원정 한 번으로 기록하는 작은 연결 도구입니다.

## 친구가 연결하는 순서

1. [AI 원정대](https://ai-expedition-forge.automl141115.chatgpt.site)에 ChatGPT로 로그인합니다.
2. 설정에서 `연결 코드 만들기`를 누릅니다.
3. 이 플러그인을 설치한 Codex를 다시 시작하고, 표시된 hook 내용을 검토한 뒤 신뢰합니다.
4. Codex에 `AI 원정대 연결 코드 ABC234 연결해줘`라고 입력합니다.
5. 다음 Codex 작업부터 완료된 원정과 주간 랭킹이 자동으로 기록됩니다.

## 전송하는 정보

서버에는 무작위 원정 ID와 시작·완료 시각만 보냅니다. 질문 내용, 답변 내용, 파일 내용, 도구 출력은 보내지 않습니다.

연결 토큰은 Windows의 `%LOCALAPPDATA%\AI Expedition\device.json`에 저장됩니다. 연결에 실패해도 Codex 작업 자체는 중단하지 않습니다.
