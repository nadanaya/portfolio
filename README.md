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

## Featured Project: JipFit AI

청년 주거비 부담 위험을 예측하고, 조건에 맞는 주거 정책을 추천하는 데이터 분석/ML 대표 프로젝트입니다.

- Repository: https://github.com/nadanaya/jipfit-ai
- Stack: Python, Streamlit, scikit-learn, SQLite, SQL, pytest
- Result: Logistic Regression Accuracy 0.9308, Macro F1 0.9014
- Details: [JipFit AI 상세 보기](images/jipfit/README.md)

## Projects

1. [JipFit AI](images/jipfit/README.md)
   - Python, Streamlit, SQLite 기반 청년 주거비 부담 예측 및 정책 추천 프로젝트
   - Logistic Regression 기준 Accuracy 0.9308, Macro F1 0.9014

2. [Weather Forecast Error](images/weather/README.md)
   - 기상청 단기예보와 서울 ASOS 관측 데이터를 결합한 공공 API 데이터 파이프라인
   - 시간대별 강수 예보 오차 여부를 `forecast_error` 분류 타깃으로 정의
   - Repository: https://github.com/nadanaya/weather-forecast-error

3. [Pigge Server](images/pigge/README.md)
   - Java 17, Spring Boot, JPA 기반 가계부 백엔드
   - 수입/지출 거래 저장, 사용자별 조회, 월별 집계, 잔액 조회, AI 소비 분석

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

- JipFit AI: 주거비 부담 예측 및 정책 추천 ML
- Weather Forecast Error: 공공 API 기반 예보 오차 데이터셋 구축
- AI Agent System: 회의/업무 데이터 기반 운영 자동화 분석

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
- JipFit AI: https://github.com/nadanaya/jipfit-ai
- Weather Forecast Error: https://github.com/nadanaya/weather-forecast-error
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
