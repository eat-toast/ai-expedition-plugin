# Security

보안 문제는 공개 Issue에 비밀값을 붙여 넣지 말고, 재현 방법과 영향만 적어 알려주세요.

다음 값은 공유하면 안 됩니다.

- `%LOCALAPPDATA%\AI Expedition\device.json`의 내용
- 연결 토큰
- 아직 사용하지 않은 6자리 연결 코드

플러그인은 질문, 답변, 파일 내용, 파일 경로, 도구 출력을 서버로 보내지 않습니다. 로컬 연결을 끊으려면 Codex를 종료한 뒤 `device.json`을 삭제하세요.
