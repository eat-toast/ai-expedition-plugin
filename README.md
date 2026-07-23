# AI Expedition Plugin

Codex 작업을 친구들과 함께 즐기는 **AI 원정대** 공식 플러그인입니다. Codex 작업이 끝날 때마다 원정 완료 기록이 쌓이고, 친구들과 주간 랭킹을 볼 수 있습니다.

- 게임: [AI 원정대 열기](https://ai-expedition-forge.automl141115.chatgpt.site)
- 현재 버전: `0.1.0`
- 비용: 친구 테스트 단계에서는 무료

## 설치하기

Codex 터미널에서 아래 두 줄을 차례대로 실행합니다.

```bash
codex plugin marketplace add eat-toast/ai-expedition-plugin
codex plugin add ai-expedition@ai-expedition-friends
```

설치가 끝나면 Codex를 다시 시작합니다. 처음 표시되는 hook 내용을 읽고 신뢰할 수 있을 때만 허용하세요.

## 게임 계정 연결하기

1. [AI 원정대](https://ai-expedition-forge.automl141115.chatgpt.site)에 ChatGPT로 로그인합니다.
2. 설정에서 **연결 코드 만들기**를 누릅니다.
3. Codex에 `AI 원정대 연결 코드 ABC234 연결해줘`라고 입력합니다.
4. 다음 Codex 작업부터 완료한 원정이 랭킹에 반영됩니다.

연결 코드는 한 번만 쓸 수 있고 10분 후 만료됩니다.

## 어떤 정보를 보내나요?

플러그인은 무작위 원정 ID와 시작·완료 시각만 게임 서버로 보냅니다. 질문, 답변, 파일 내용, 파일 경로, 도구 출력은 보내지 않습니다.

Windows 연결 정보는 `%LOCALAPPDATA%\AI Expedition\device.json`에 저장됩니다. 연결에 실패해도 Codex 작업은 계속됩니다.

## 삭제 또는 문제 해결

Codex 앱의 **Plugins** 화면에서 AI Expedition을 삭제하거나 다시 설치할 수 있습니다. 연결 정보까지 지우려면 Codex를 종료한 뒤 위의 `device.json` 파일을 삭제하세요.

문제가 생기면 [GitHub Issues](https://github.com/eat-toast/ai-expedition-plugin/issues)에 운영체제와 오류 메시지만 남겨주세요. 토큰이나 `device.json` 내용은 올리지 마세요.

## AI 개발자 안내

코딩 AI가 이 저장소를 수정할 때는 먼저 [`AGENTS.md`](AGENTS.md)를 읽어야 합니다. 제품 목적, 파일별 역할, 개인정보 금지사항, 버전 변경 규칙과 배포 전 검사가 정리되어 있습니다.
