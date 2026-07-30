# NaYoung Portfolio

신입 데이터 분석가와 신입 백엔드 개발자 지원을 위해 구성한 포트폴리오입니다.
하나의 저장소를 유지하되, 평가 기준이 다른 두 직무를 별도 상세 페이지로 분리했습니다.

## Live Pages

- Main: https://nadanaya.github.io/portfolio/
- Data Analyst: https://nadanaya.github.io/portfolio/data.html
- Backend Developer: https://nadanaya.github.io/portfolio/backend.html

## Page Structure

```text
portfolio/
  index.html          # 김나영 소개 + 직무 선택
  data.html           # 데이터 분석 지원용 상세 페이지
  backend.html        # 백엔드 지원용 상세 페이지
  README.md
  images/
    jipfit/
    weather/
    ai-agent/
    pigge/
    dentallink/
    4party/
    life-manager/
```

## Main Page

`index.html`은 긴 프로젝트 나열 페이지가 아니라 지원 직무 선택 페이지입니다.

- 김나영 소개
- 데이터 분석 포트폴리오 이동
- 백엔드 포트폴리오 이동
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

`data.html`은 데이터 분석가 직무에서 중요하게 보는 기준에 맞춰 구성했습니다.

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

JipFit AI는 합성 시나리오 기반 기술 검증 결과임을 명시하고, 성능 수치와 오류 분석 근거를 함께 연결합니다.

## Backend Developer Page

`backend.html`은 백엔드 개발자 직무에서 중요하게 보는 기준에 맞춰 구성했습니다.

### Representative Projects

1. Pigge Server
2. DentalLink
3. 4Party

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

Pigge Server는 실제 Spring Boot 서버 구현 근거를 중심으로 배치하고, DentalLink와 4Party는 별도 백엔드 서버가 아니라 Supabase/Firebase 기반 서비스 데이터 구조로 설명합니다.

## GitHub Links

- Portfolio Repository: https://github.com/nadanaya/portfolio
- GitHub Profile: https://github.com/nadanaya
- JipFit AI: https://github.com/nadanaya/jipfit-ai
- Weather Forecast Error: https://github.com/nadanaya/weather-forecast-error
- Pigge Server: https://github.com/nadanaya/pigge_server
- AI Agent System: https://github.com/nadanaya/ai-agent
