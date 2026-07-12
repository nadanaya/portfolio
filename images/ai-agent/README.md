# AI Agent System

포트폴리오 공개용 요약 자료입니다. 실제 `.env`, 토큰, DB 파일, PDF 산출물은 포함하지 않았습니다.

## Source Repository

실제 공개 가능한 AI Agent 코드는 별도 저장소에서 확인할 수 있습니다.

https://github.com/nadanaya/ai-agent

포트폴리오 저장소에는 프로젝트 소개와 기여 내용을 정리하고, 실제 코드 저장소는 위 링크로 분리했습니다.

## Project Type

Team Project

## My Contribution

- AI Agent 기반 팀 프로젝트의 워크플로 구조 정리
- 회의 요약, 일정 추적, 기여도 산정, 최종 보고서 생성 흐름 구현 및 검토
- PostgreSQL/Supabase 기반 데이터 저장 구조와 SQL 스키마 검토
- Discord Bot 연동 흐름과 Python 패키지 구조 분리
- LLM 응답 결과를 Markdown 보고서로 정리하는 기능 검토

## Main Features

- 회의 내용 요약
- 액션 아이템 추출
- 일정 상태 추적
- 팀원별 기여도 분석
- 최종 보고서 생성
- Discord Bot 기반 명령 흐름

## Tech Stack

- Python
- LangGraph
- LLM
- PostgreSQL / Supabase
- Discord Bot
- Markdown report generation

## Public Code Structure

`nadanaya/ai-agent` 저장소의 주요 구조입니다.

```text
ai_agent/
  _core/       scoring and analysis logic
  _graph/      workflow and graph nodes
  _services/   database, LLM, PDF, project-data services
  _discord/    Discord bot entry points
  _cli/        local preview command
data/          sample project payloads
sql/           Supabase schema and seed scripts
tests/         pytest tests
```

## Security Note

민감 정보 보호를 위해 아래 항목은 공개 저장소에 업로드하지 않았습니다.

- `.env`
- API key / token
- DB 파일
- audit archive PDF
- 가상환경 폴더
