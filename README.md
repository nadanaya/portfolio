# NaYoung Portfolio

신입 데이터 분석가 및 백엔드 개발자 포지션을 목표로 구성한 포트폴리오입니다.
단순 기능 구현 목록보다 **문제 정의, 데이터 흐름, 분석 지표, 백엔드 안정성 개선**을 중심으로 정리했습니다.

## Live Page

https://nadanaya.github.io/portfolio/

## Target Position

- 신입 데이터 분석가
- 신입 백엔드 개발자
- 관심 분야: 은행, IT, 핀테크, IT 플랫폼
- 핵심 메시지: 데이터를 이해하고, 서비스 문제를 정의하며, 안정적인 백엔드 구조로 개선할 수 있는 지원자

## Portfolio Focus

### Data Analyst

- SQL/Python 기반 데이터 추출, 정제, 집계
- 사용자 행동 및 서비스 운영 데이터의 지표화
- KPI 관점의 문제 정의와 개선 액션 제안
- Tableau/Excel/Python 리포트로 분석 결과 전달

### Backend Developer

- 거래성 데이터의 정합성과 트랜잭션 처리
- 대용량 조회 성능 개선을 위한 인덱스, 캐싱, 집계 구조
- 예외 처리, 테스트, API 문서화 등 코드 품질 관리
- 금융/핀테크 도메인에 필요한 안정성 중심 설계

## Pigge Server

`nadanaya/pigge_server` 저장소의 실제 Spring Boot 백엔드 구조를 바탕으로 정리한 대표 프로젝트입니다.

- Repository: https://github.com/nadanaya/pigge_server
- Stack: Java 17, Spring Boot, Spring Data JPA, H2, Gradle, RestTemplate, Ollama
- Core API:
  - `POST /api/transactions`: 수입/지출 거래 저장
  - `GET /api/transactions/{userEmail}`: 사용자별 전체 거래 조회
  - `GET /api/transactions/month`: 사용자별 월별 거래 조회
  - `GET /api/transactions/balance/{userEmail}`: 총 잔액 조회
  - `POST /api/transactions/with-ai`: 거래 저장 후 월별 통계 기반 AI 요약 생성
  - `POST /api/analysis/expense`: 소비 내역 텍스트 기반 AI 분석

### Implemented Data Flow

1. 사용자가 수입/지출 거래를 등록합니다.
2. `TransactionController`가 요청을 받고 `TransactionService`로 전달합니다.
3. `Transaction` JPA Entity가 `TransactionRepository`를 통해 저장됩니다.
4. 월별 조회와 월별 통계는 `userEmail`, `year`, `month`, `type` 기준으로 집계됩니다.
5. `AiClient` 추상화와 `OllamaClient` 구현을 통해 소비 분석 코멘트를 생성합니다.

### Data Analysis Expansion

직접 개발 및 운용한 가계부 앱 데이터를 활용해 다음 3가지 분석 프로젝트로 확장할 수 있습니다.

1. 예산 초과 예측 및 알림 전략
   - 데이터: 수입/지출 내역, 카테고리, 날짜, 고정비 여부, 예산
   - 분석: 월 중간 누적 지출률, 예산 초과 여부, 카테고리별 기여도
   - 기대효과: 월말 예산 초과 가능성을 조기 탐지하고 개인화 알림으로 지출 개선

2. 소비 카테고리 기반 사용자 세그먼트 분석
   - 데이터: 월별 카테고리 지출 비중, 고정비/변동비, 주중/주말 소비
   - 분석: 소비 유형 분류, 저축률, 지출 집중도, 변동성
   - 기대효과: 사용자 유형별 예산 추천, 구독 점검, 적금/비상금 목표 제안

3. 월별 현금흐름 예측 및 재무 안정성 지표 설계
   - 데이터: 월별 수입, 고정비, 변동비, 잔액, 반복 결제일
   - 분석: 월말 예상 잔액, 고정비 비중, 비상자금 확보 가능 개월 수
   - 기대효과: 개인 금융관리 서비스의 리스크 탐지 및 맞춤형 자산관리 기능으로 확장

## Backend Deep-Dive Ideas From Pigge Server

현재 `pigge_server` 코드에서 자연스럽게 이어지는 백엔드 개선 주제입니다.

1. 거래 저장과 AI 요약 흐름의 정합성 개선
   - Issue: `POST /api/transactions/with-ai` 흐름에서 저장과 요약 생성이 분리되어 중복 저장 또는 부분 실패 가능성이 생길 수 있음
   - Action: 저장 트랜잭션 경계 정리, 저장 후 월별 통계 재조회, AI 실패 시 fallback 응답과 로그 분리
   - Result: 거래 데이터는 안정적으로 저장하고 AI 분석 실패가 핵심 거래 흐름을 막지 않도록 개선

2. 월별/카테고리별 통계 API 성능 최적화
   - Issue: `YEAR(date)`, `MONTH(date)` 함수 기반 조회는 데이터가 많아질수록 인덱스를 효율적으로 활용하기 어려움
   - Action: `startDate <= date < endDate` 범위 조건, `userEmail + date + type` 복합 인덱스, 월별 통계 캐싱
   - Result: 월별 거래 조회와 월별 집계 API의 응답 시간 및 DB 부하 개선

3. 통계 데이터 배치 처리와 알림 기능
   - Issue: 홈 화면, 잔액 조회, AI 요약에서 매번 원장 데이터를 집계하면 반복 조회 비용이 커질 수 있음
   - Action: 일/월 단위 집계 테이블, 스케줄러 또는 Batch, 실패 재처리 로그, 알림 대상 추출 쿼리
   - Result: 월간 리포트, 예산 초과 알림, AI 소비 분석을 운영 가능한 구조로 확장

## Projects

1. [Pigge Server](images/pigge/README.md)
   - Java 17, Spring Boot, JPA 기반 가계부 백엔드
   - 수입/지출 거래 저장, 사용자별 조회, 월별 집계, 잔액 조회, AI 소비 분석

2. [JipFit AI](images/jipfit/README.md)
   - Python, Streamlit, SQLite 기반 청년 주거비 부담 예측 및 정책 추천 프로젝트
   - Logistic Regression 기준 Accuracy 0.9308, Macro F1 0.9014

3. [Weather Forecast Error](images/weather/README.md)
   - 기상청 단기예보와 서울 ASOS 관측 데이터를 결합한 공공 API 데이터 파이프라인
   - 시간대별 강수 예보 오차 여부를 `forecast_error` 분류 타깃으로 정의

4. [DentalLink](images/dentallink/README.md)
   - Flutter, Supabase, PostgreSQL 기반 치과 통합 관리 프로젝트
   - 환자, 예약, 대기열, 공지사항 데이터 흐름 정리

5. [AI Agent System](images/ai-agent/README.md)
   - Python, LangGraph, PostgreSQL 기반 프로젝트 관리 자동화 Agent
   - 회의 요약, Action Item, 일정 리마인드, 리스크 분석, Markdown 보고서 생성

6. [4Party](images/4party/README.md)
   - Android, Kotlin, Firebase 기반 택시 동승 매칭 서비스
   - 사용자 인증, 파티 생성/참여, 모집 상태 관리

7. [Life Manager Android App](images/life-manager/README.md)
   - Android, Java, Room 기반 생활 기록 관리 앱
   - 수면, 공부, 스마트폰 사용, 만보기 데이터 기록 및 7일 지표 시각화

## Recommended Portfolio Tracks

### Data Analyst Main Projects

- Pigge: 개인 금융 데이터 분석 및 AI 소비 요약
- JipFit AI: 주거비 부담 예측 및 정책 추천 ML
- Weather Forecast Error: 공공 API 기반 예보 오차 데이터셋 구축

### Backend Main Projects

- Pigge Server: 금융 거래 API, 월별 집계, AI 연동
- DentalLink: 병원 운영 데이터 흐름 및 Flutter-Supabase 연동
- 4Party: 매칭 서비스, 인증, 상태 관리, Firestore 구조

## Skills

- Analysis: Python, SQL, Pandas, NumPy, Excel, Tableau
- Backend/Data: PostgreSQL, Supabase, Firebase, REST API
- App/Implementation: Android, Flutter, Java, Kotlin, Dart
- Engineering Practice: Git, GitHub, 테스트, 문서화, 트러블슈팅

## Public Code Links

- GitHub Profile: https://github.com/nadanaya
- Portfolio Repository: https://github.com/nadanaya/portfolio
- AI Agent System: https://github.com/nadanaya/ai-agent

## Repository Structure

```text
portfolio/
  index.html
  README.md
  images/
    pigge/
    jipfit/
    weather/
    dentallink/
    ai-agent/
    4party/
    life-manager/
    figma-plugin/
  tools/
```
