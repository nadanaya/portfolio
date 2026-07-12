# Figma Plugin

채널톡, 무신사, 카카오페이증권 시나리오를 기반으로 Figma 캔버스에 운영 리스크 보드와 금융 케어 카드를 자동 생성하는 개인 플러그인 프로젝트입니다.

단순한 UI 보조 도구가 아니라, 기업별 UX·운영 시나리오를 구조화한 뒤 Figma 프레임으로 변환해 제품 기획, 운영 검토, 화면 설계 과정에서 바로 확인할 수 있도록 구성했습니다.

## Project Type

Personal Project

## My Contribution

- 기업별 UX 시나리오 기반 Figma 플러그인 MVP 기획 및 구현
- Figma Plugin API 기반 프레임·텍스트·카드 노드 생성 로직 개발
- 플러그인 UI와 `code.js` 간 메시지 계약 설계 및 오류 처리
- 로컬 스냅샷 데이터를 활용한 카드 생성 흐름 구성
- 생성된 프레임을 캔버스 중앙에 배치하고 자동 선택하는 사용자 흐름 구현

## Main Features

- 채널톡 AI 상담 운영 리스크 보드 생성
- 무신사 운영 리스크 스냅샷 카드 생성
- 카카오페이증권 해외주식 케어 카드 생성
- 입력된 시나리오 기반 Figma 카드·보드 자동 생성
- 플러그인 UI와 `code.js` 간 `postMessage` 기반 명령 전달
- 최근 선택값 저장과 불러오기 처리
- 카드 생성 실패 시 오류 메시지와 상태 표시

## Tech Stack

- Figma Plugin API
- JavaScript
- HTML
- CSS

## Implementation Details

```text
figma_plugin/
├─ manifest.json
├─ ui.html
├─ code.js
└─ snapshots/
```

- `ui.html`: 사용자가 시나리오를 선택하고 카드 생성을 요청하는 플러그인 UI
- `code.js`: Figma Plugin API로 Frame, Text, Card 노드를 생성하는 메인 프로세스
- `parent.postMessage(...)`: UI에서 생성 명령 전달
- `figma.ui.onmessage`: 메인 프로세스에서 명령 수신 후 Figma 캔버스에 프레임 생성
- `figma.viewport.center`: 생성된 프레임을 현재 캔버스 중앙에 배치
- `figma.currentPage.selection`: 생성 결과를 자동 선택해 사용자가 바로 확인할 수 있게 처리

## Example Use Cases

- ChannelTalk: AI 상담 운영 리스크, 심각도, 담당 모듈, 권장 조치, 운영 지표를 보드로 생성
- Musinsa: 쿠폰·프로모션·상품 데이터 검수 같은 운영 리스크를 증빙 자료와 담당팀이 포함된 카드로 생성
- KakaoPay Securities: 해외주식 자연어 요청을 기반으로 조건 초안, 알림 문구, 안전 고지가 포함된 모바일 케어 카드 생성

## Troubleshooting

- UI와 메인 프로세스의 메시지 타입이 다르면 카드 생성 함수가 실행되지 않는 문제가 있어 `create-card` 메시지 계약을 기준으로 정리했습니다.
- 개발용 import 환경에서 `figma.clientStorage`가 제한될 수 있어 최근 선택값 저장 실패 시에도 카드 생성은 계속 진행되도록 처리했습니다.
- 외부 API 호출 없이 로컬 스냅샷 데이터로 동작하도록 구성해 심사와 데모 환경에서 안정적으로 실행되도록 했습니다.

