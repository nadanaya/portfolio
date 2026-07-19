# Life Manager Android App

생활관리 기능을 Android 앱으로 구현한 프로젝트입니다. 수면, 공부, 휴대폰 사용, 만보기 데이터를 기록하고 최근 7일 기준 그래프로 확인할 수 있도록 구성했습니다.

## Analysis View

- Problem: 생활 기록을 단순 저장만 하면 사용자가 자신의 패턴을 이해하거나 행동을 조정하기 어렵습니다.
- Data: 날짜별 수면 시간, 공부 시간, 휴대폰 사용 시간, 걸음 수를 로컬 DB에 저장했습니다.
- Metrics: 최근 7일 기록, 주간 평균, 날짜별 변화량을 계산해 화면에 표시했습니다.
- Action: 빈 날짜를 포함한 최근 7일 기준을 먼저 만들고, 저장된 값을 채워 그래프와 분석 문구가 안정적으로 보이게 했습니다.
- Result: 사용자가 최근 7일 생활 패턴과 주간 평균을 한 화면에서 확인할 수 있게 했습니다.

## Key Numbers

- 4 life data types: 수면, 공부, 휴대폰 사용, 걸음 수
- 7-day metric window: 최근 7일 기준 그래프와 주간 평균
- 3 Room entities shown in public code evidence: LifeLogEntity, StudyLog, PedometerLog

## Project Type

Team Project

## Project Period

2025.09 ~ 2025.12

## My Contribution

- 담당: Android 생활 기록 입력·저장·조회 화면 구현 참여
- 담당: 생활 기록 데이터의 입력·저장·조회 흐름 구현
- 담당: UI와 Room 기반 로컬 데이터 저장 로직 연동
- 담당: 사용자 입력값 검증과 예외 상황 처리
- 담당: 최근 7일 데이터를 기반으로 그래프와 주간 평균 표시

## Main Features

- 수면, 공부, 휴대폰 사용 시간 입력 및 저장
- 최근 7일 기준 생활 기록 그래프 시각화
- 주간 평균 계산 및 분석 문구 표시
- Room Migration을 통한 만보기 데이터 테이블 확장
- 날짜 기반 데이터 조회

## Tech Stack

- Android
- Java
- Room
- SQLite
- XML
- UI/UX

## Screens & Evidence

### Study Time Graph

![Life Manager study graph](study-graph.png)

최근 7일 공부 시간을 막대 그래프로 보여주고, 주간 평균 공부 시간을 계산해 표시하는 화면입니다.

### Sleep Time Graph

![Life Manager sleep graph](sleep-graph.png)

수면 기록을 날짜별로 시각화하고 평균 수면 시간을 함께 보여주는 화면입니다.

### Room Database Code

![Life Manager Room database code](room-database-code.png)

`LifeLogDatabase`에서 `LifeLogEntity`, `StudyLog`, `PedometerLog`를 Room Entity로 관리하고, 버전 마이그레이션을 통해 만보기 테이블을 확장한 코드입니다.

### Record Fragment Code

![Life Manager record fragment code](record-fragment-code.png)

생활 기록 입력 화면에서 날짜 선택, 수면 시간, 휴대폰 사용 시간 입력값을 받아 Room DB에 저장하는 흐름입니다.

## App Flow

```mermaid
flowchart LR
    User[사용자] --> Screen[Android 화면]
    Screen --> Input[수면 / 공부 / 휴대폰 / 만보기 입력]
    Input --> Validation[입력값 검증]
    Validation --> Room[Room DAO]
    Room --> DB[(SQLite)]
    DB --> Chart[최근 7일 그래프]
    Chart --> Average[주간 평균 표시]
```

## Data Scope

- 수면 기록: 날짜, 수면 시간
- 공부 기록: 날짜, 공부 시간
- 휴대폰 기록: 날짜, 사용 시간
- 만보기 기록: 날짜, 걸음 수

## Troubleshooting

### Room Migration으로 만보기 테이블을 추가하는 문제

기존 생활 기록 데이터가 있는 상태에서 만보기 기능을 추가해야 했기 때문에 DB 버전 변경 시 기존 테이블이 손상되지 않도록 마이그레이션을 분리했습니다. 새 테이블을 추가하면서 기존 수면, 공부, 휴대폰 기록 조회 흐름은 유지되도록 구성했습니다.

### 최근 7일 그래프 기준 정리

날짜별 기록이 비어 있는 날에도 그래프 기준이 흔들리지 않도록 최근 7일 범위를 먼저 만들고, 해당 날짜에 저장된 값이 있을 때만 데이터를 채우는 방식으로 화면 표시 기준을 맞췄습니다.


