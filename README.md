# NaYoung Portfolio

데이터 분석, 백엔드 개발, AI 엔지니어링, 금융 IT 관점을 함께 정리한 포트폴리오입니다.
하나의 저장소를 유지하되, 지원 직무 관점별로 상세 페이지를 분리했습니다. 같은 GitHub
프로젝트라도 페이지마다 강조하는 지점이 다릅니다 (예: Pigge Server는 backend.html에서는
API/JPA 구현을, finance-it.html에서는 거래 정합성·잔액 계산을 강조).

## 2026-09-01 Submission Priority

현재 취업용 조합은 **금융 IT 93 > 백엔드 92 > AI 엔지니어 91 > 데이터 분석 84** 순서로 판단합니다. 새 프로젝트를 늘리기보다 직무별 이력서 순서를 분리하고, 정량 근거를 보강하는 전략입니다.

- 금융 IT / 백엔드: Pigge Server를 1순위로 두고 거래 데이터 정합성, 잔액 계산, 월별 조회, 테스트 4건 통과를 강조
- AI 엔지니어: AI Agent System을 1순위로 두고 Agentic RAG, Tool Use, DB 검색, fallback 흐름을 강조
- 데이터 분석: JipFit AI를 1순위로 두고 6,000개 합성 시나리오, Accuracy 0.9375, Macro F1 0.9185를 본문에 직접 노출
- 다음 보강: AI Agent Evaluation 20~50개 테스트셋, Docker/CI/CD 중 1개를 기존 프로젝트에 적용

## Live Pages

- Main: https://nadanaya.github.io/portfolio/
- Data Analyst: https://nadanaya.github.io/portfolio/data.html
- Backend Developer: https://nadanaya.github.io/portfolio/backend.html
- AI Engineer: https://nadanaya.github.io/portfolio/ai.html
- Finance IT: https://nadanaya.github.io/portfolio/finance-it.html

## Page Structure

```text
portfolio/
  index.html          # 김나영 소개 + 페이지 선택
  data.html           # 데이터 분석 상세 페이지
  backend.html        # 백엔드 개발 상세 페이지
  ai.html             # AI 엔지니어 상세 페이지
  finance-it.html     # 금융 IT 상세 페이지
  README.md
  images/
    jipfit/
    weather/
    ai-agent/
    festai/
    pigge/
    dentallink/
    4party/
    life-manager/
```

## Main Page

`index.html`은 긴 프로젝트 나열 페이지가 아니라 지원 직무 관점 선택 페이지입니다.

- 김나영 소개
- 데이터 분석 / 백엔드 / AI 엔지니어 / 금융 IT 포트폴리오 이동
- 포트폴리오 GitHub 저장소 링크
- 공통 역량 요약

공통 역량은 다음 항목만 간결하게 보여줍니다.

- Python / SQL
- Java / Spring Boot
- PostgreSQL
- REST API
- 데이터 모델링
- 테스트와 문서화

## Data Analyst Page

`data.html`은 데이터 분석 프로젝트에서 중요하게 보는 기준에 맞춰 구성했습니다.

### Representative Projects

1. JipFit AI
2. Weather Forecast Error
3. AI Agent System

### Evaluation Criteria

각 프로젝트는 다음 5가지 기준으로만 설명합니다.

- 문제
- 데이터
- 분석 방법
- 결과
- 개선 방향

백엔드, Flutter, Android 구현 설명은 최소화하고 문제 정의, 데이터 출처, 지표 설계, 모델 검증, 비즈니스 활용 가능성을 중심에 둡니다.

JipFit AI는 합성 테스트 데이터 기반 결과임을 명시하고, 모델 비교 차트, 혼동행렬, 오류 분석 근거를 함께 연결합니다.

## Backend Developer Page

`backend.html`은 백엔드 개발 프로젝트에서 중요하게 보는 기준에 맞춰 구성했습니다.

### Representative Projects

1. Pigge Server (Java 17·Spring Boot·Spring Data JPA 기반 거래 API, 테스트 4건 통과)
2. FESTAI
3. AI Agent System
4. DentalLink

### Supporting Project

- Life Manager

### Evaluation Criteria

각 프로젝트는 다음 5가지 기준으로 설명합니다.

- 도메인
- 데이터 모델
- API 구조
- 문제 해결
- 테스트 및 개선

모델 성능이나 데이터 분석 결과보다 데이터 정합성, API 설계, 조회 구조, 예외 처리, 테스트 계획을 앞에 둡니다.

Pigge Server는 Spring Boot·JPA 기반 거래 API로, FESTAI는 FastAPI·PostgreSQL 기반 운영 백엔드로 구분해 설명합니다. 백엔드 지원 이력서에서는 `Pigge Server → FESTAI → AI Agent System → DentalLink` 순서를 우선 사용합니다.

## AI Engineer Page

`ai.html`은 AI 연동·자동화 관점에서 같은 프로젝트를 다시 구성한 페이지입니다.

### Representative Projects

1. AI Agent System
2. FESTAI (Alan AI 연동 부분)
3. JipFit AI (모델 비교·평가 부분)

각 프로젝트에서 AI 관련 부분만 골라 아키텍처, 실패 시 폴백 처리, 모델 평가 기준으로 설명합니다.
Pigge Server의 AI 소비 요약 연동과 BDA 학회 AI Agent 수업(HuggingFace·OpenAI·NLP·RAG 학습)은
보조 카드로 덧붙입니다.

AI Agent는 구현 근거가 충분하므로 다음 보강은 정량 Evaluation입니다. Recall@K, Precision@K, 응답 성공률, tool-call 성공률, latency, hallucination 사례를 20~50개 테스트셋으로 기록합니다.

## Finance IT Page

`finance-it.html`은 거래 데이터 정합성과 리스크 분류 관점에서 같은 프로젝트를 다시 구성한 페이지입니다.

### Representative Projects

1. Pigge Server (거래 저장·잔액 계산·월별 집계)
2. FESTAI (인증·권한·게시 데이터 정합성·fallback)
3. AI Agent System (AI 자동화와 데이터 구조)
4. DentalLink (개인정보성 데이터와 API/DB 정합성)

금융 IT 이력서에서는 `Pigge → FESTAI → AI Agent → DentalLink` 순서를 사용합니다. 핵심 표현은 거래 데이터 정합성, 데이터 무결성, 인증·권한, 예외 처리, 장애 fallback, 회귀 테스트, API 계약, 감사 가능한 데이터 흐름입니다.

## GitHub Links

- Portfolio Repository: https://github.com/nadanaya/portfolio
- GitHub Profile: https://github.com/nadanaya
- JipFit AI: https://github.com/nadanaya/jipfit-ai
- Weather Forecast Error: https://github.com/nadanaya/weather-forecast-error
- FESTAI Backend: https://github.com/FEST-ON/Backend
- FESTAI Organization: https://github.com/FEST-ON
- Pigge Server: https://github.com/nadanaya/pigge_server
- AI Agent System: https://github.com/nadanaya/ai-agent
