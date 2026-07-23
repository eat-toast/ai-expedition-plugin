# AI Expedition Plugin

Codex에서 하던 일이 그대로 한 번의 원정이 됩니다. 평소처럼 Codex에 작업을 맡기면 시작과 완료가 자동으로 기록되고, 얻은 장비로 전투력을 높여 친구들과 랭킹을 겨룰 수 있습니다.

[게임 열기](https://ai-expedition-forge.automl141115.chatgpt.site) · 현재 버전 `0.1.0` · 친구 테스트 기간 무료

![AI 원정대의 원정 및 장비 화면](docs/images/expedition.png)

## 어떻게 조작하나요?

1. **Codex에서는 평소처럼 작업합니다.** 질문을 보내면 원정이 시작되고, 작업이 끝나면 원정 완료와 보상이 자동으로 기록됩니다. 게임 때문에 따로 누를 버튼은 없습니다.
2. **원정 화면에서 장비를 정리합니다.** 왼쪽의 **최고 전투력 자동 장착**으로 가장 강한 장비를 장착할 수 있습니다. 오른쪽 전리품을 누르면 직접 장착할 수 있고, **잠금**한 장비는 합성·분해에서 제외됩니다.
3. **같은 등급 장비 3개를 합성합니다.** 장비마다 **합성**을 눌러 3개를 고르거나 **자동 합성**을 사용합니다. 필요 없는 장비는 분해해 재의 가루로 바꿀 수 있습니다.
4. **월드보스와 랭킹에 도전합니다.** 상단 탭에서 이동합니다. 월드보스는 장착 무기에 맞는 스킬이 자동 발동하며, 랭킹은 레벨·연속 로그인·전투력·주간 원정·최장 원정을 비교합니다.

### 월드보스

30분마다 무료로 공격할 수 있습니다. 장착한 무기와 현재 전투력을 확인한 뒤 **공격**을 누르세요.

![장착 무기 스킬로 공격하는 월드보스 화면](docs/images/world-boss.png)

### 친구 랭킹

종목 탭을 누르면 순위와 집계 규칙을 볼 수 있습니다. 공식 순위는 브라우저 저장값이 아니라 서버가 받은 Codex 원정 기록으로 계산합니다.

![레벨과 원정 기록을 비교하는 랭킹 화면](docs/images/ranking.png)

## 설치하기

Codex 터미널에서 아래 두 줄을 차례대로 실행합니다.

```bash
codex plugin marketplace add eat-toast/ai-expedition-plugin
codex plugin add ai-expedition@ai-expedition-friends
```

설치가 끝나면 Codex를 다시 시작합니다. 처음 표시되는 hook 내용을 읽고 신뢰할 수 있을 때만 허용하세요.

## 게임 계정 연결하기

1. [AI 원정대](https://ai-expedition-forge.automl141115.chatgpt.site)에 ChatGPT로 로그인합니다.
2. 화면 상단의 **연결 코드 받기**를 누릅니다.
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

코딩 AI가 이 저장소를 수정할 때는 먼저 [`AGENTS.md`](https://github.com/eat-toast/ai-expedition-plugin/blob/main/AGENTS.md)를 읽어야 합니다. 제품 목적, 파일별 역할, 개인정보 금지사항, 버전 변경 규칙과 배포 전 검사가 정리되어 있습니다.
