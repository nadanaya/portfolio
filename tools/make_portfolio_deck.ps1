param(
  [string]$OutputPath = "C:\Users\yeoh0\포트폴리오\outputs\kim-nayoung-portfolio-current.pptx"
)

$ErrorActionPreference = "Stop"

$repo = "C:\Users\yeoh0\포트폴리오\portfolio"
$extracted = "C:\Users\yeoh0\포트폴리오\extracted_images"
$profilePhoto = "C:\Users\yeoh0\포트폴리오\outputs\resume-photo-candidates\candidate_01.jpg"
$outDir = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$pp = New-Object -ComObject PowerPoint.Application
$pp.Visible = [Microsoft.Office.Core.MsoTriState]::msoTrue
$presentation = $pp.Presentations.Add()
$presentation.PageSetup.SlideWidth = 960
$presentation.PageSetup.SlideHeight = 540

$layoutBlank = 12
$colorInk = 0x171717
$colorMuted = 0x656565
$colorLine = 0xD4DBDE
$colorPaper = 0xF7FAFB
$colorPanel = 0xFFFFFF
$colorAccent = 0x686F25
$colorAccentDark = 0x474C16
$colorWarm = 0x355FB2
$colorSoft = 0xE3ECF0

function Add-TextBox {
  param(
    [object]$Slide,
    [string]$Text,
    [double]$Left,
    [double]$Top,
    [double]$Width,
    [double]$Height,
    [int]$Size = 18,
    [int]$Color = $colorInk,
    [bool]$Bold = $false
  )
  $shape = $Slide.Shapes.AddTextbox(1, $Left, $Top, $Width, $Height)
  $shape.TextFrame.MarginLeft = 0
  $shape.TextFrame.MarginRight = 0
  $shape.TextFrame.MarginTop = 0
  $shape.TextFrame.MarginBottom = 0
  $shape.TextFrame.TextRange.Text = $Text
  $shape.TextFrame.TextRange.Font.Name = "맑은 고딕"
  $shape.TextFrame.TextRange.Font.Size = $Size
  $shape.TextFrame.TextRange.Font.Color.RGB = $Color
  $shape.TextFrame.TextRange.Font.Bold = if ($Bold) { -1 } else { 0 }
  return $shape
}

function Add-Rule {
  param([object]$Slide, [double]$Left, [double]$Top, [double]$Width)
  $line = $Slide.Shapes.AddShape(1, $Left, $Top, $Width, 1.2)
  $line.Fill.ForeColor.RGB = $colorLine
  $line.Line.Visible = 0
}

function Add-Card {
  param([object]$Slide, [double]$Left, [double]$Top, [double]$Width, [double]$Height, [int]$Fill = $colorPanel)
  $shape = $Slide.Shapes.AddShape(5, $Left, $Top, $Width, $Height)
  $shape.Fill.ForeColor.RGB = $Fill
  $shape.Line.ForeColor.RGB = $colorLine
  $shape.Line.Weight = 1
  return $shape
}

function Add-Tag {
  param([object]$Slide, [string]$Text, [double]$Left, [double]$Top, [double]$Width)
  $shape = $Slide.Shapes.AddShape(5, $Left, $Top, $Width, 24)
  $shape.Fill.ForeColor.RGB = 0xEEF0E4
  $shape.Line.ForeColor.RGB = 0xD1D5B9
  $shape.TextFrame.TextRange.Text = $Text
  $shape.TextFrame.TextRange.Font.Name = "맑은 고딕"
  $shape.TextFrame.TextRange.Font.Size = 10
  $shape.TextFrame.TextRange.Font.Bold = -1
  $shape.TextFrame.TextRange.Font.Color.RGB = $colorAccentDark
  $shape.TextFrame.MarginLeft = 8
  $shape.TextFrame.MarginRight = 8
  $shape.TextFrame.MarginTop = 2
  $shape.TextFrame.MarginBottom = 2
}

function Add-Header {
  param([object]$Slide, [string]$Number, [string]$Title, [string]$Subtitle)
  Add-TextBox $Slide $Number 54 34 180 22 11 $colorAccentDark $true | Out-Null
  Add-TextBox $Slide $Title 54 62 790 58 24 $colorInk $true | Out-Null
  Add-TextBox $Slide $Subtitle 54 105 620 42 13 $colorMuted $false | Out-Null
  Add-Rule $Slide 54 151 852 | Out-Null
}

function Add-BulletList {
  param([object]$Slide, [string[]]$Items, [double]$Left, [double]$Top, [double]$Width, [double]$Height, [int]$Size = 13)
  $text = ($Items | ForEach-Object { "• $_" }) -join [Environment]::NewLine
  $shape = Add-TextBox $Slide $text $Left $Top $Width $Height $Size $colorInk $false
  $shape.TextFrame.TextRange.ParagraphFormat.SpaceAfter = 6
}

function Add-ImageSafe {
  param([object]$Slide, [string]$Path, [double]$Left, [double]$Top, [double]$Width, [double]$Height)
  if (Test-Path $Path) {
    try {
      Add-Card $Slide $Left $Top $Width $Height 0xF5F3EE | Out-Null
      $pic = $Slide.Shapes.AddPicture($Path, 0, -1, $Left, $Top, -1, -1)
      $pic.LockAspectRatio = 0
      $pic.Left = $Left
      $pic.Top = $Top
      $pic.Width = $Width
      $pic.Height = $Height
      $pic.Line.ForeColor.RGB = $colorLine
      return $pic
    } catch {
      $box = Add-Card $Slide $Left $Top $Width $Height 0xF5F3EE
      Add-TextBox $Slide "Visual material" ($Left + 24) ($Top + ($Height / 2) - 12) ($Width - 48) 28 15 $colorMuted $true | Out-Null
      return $box
    }
  }
}

function Add-ImageStrip {
  param([object]$Slide, [string[]]$Paths, [double]$Left, [double]$Top, [double]$Width, [double]$Height)
  $count = $Paths.Count
  if ($count -eq 0) { return }
  $gap = 10
  $itemWidth = ($Width - (($count - 1) * $gap)) / $count
  for ($i = 0; $i -lt $count; $i++) {
    Add-ImageSafe $Slide $Paths[$i] ($Left + ($i * ($itemWidth + $gap))) $Top $itemWidth $Height | Out-Null
  }
}

function New-Slide {
  $slide = $presentation.Slides.Add($presentation.Slides.Count + 1, $layoutBlank)
  $slide.FollowMasterBackground = 0
  $slide.Background.Fill.ForeColor.RGB = $colorPaper
  return $slide
}

function Add-ReadableVisual {
  param([object]$Slide, [string]$Kind, [double]$Left, [double]$Top, [double]$Width, [double]$Height)
  Add-Card $Slide $Left $Top $Width $Height 0xFFFFFF | Out-Null
  if ($Kind -eq "dental") {
    Add-TextBox $Slide "DentalLink Admin / Patient View" ($Left+22) ($Top+18) 260 24 16 $colorAccentDark $true | Out-Null
    Add-Card $Slide ($Left+24) ($Top+54) 206 216 0xF7FAFB | Out-Null
    Add-Card $Slide ($Left+38) ($Top+72) 178 28 0xE3ECF0 | Out-Null
    Add-TextBox $Slide "Waiting Queue" ($Left+50) ($Top+78) 110 16 11 $colorAccentDark $true | Out-Null
    Add-Card $Slide ($Left+38) ($Top+112) 178 34 0xFFFFFF | Out-Null
    Add-TextBox $Slide "1  김OO  ·  진료 대기" ($Left+52) ($Top+122) 130 14 11 $colorInk $true | Out-Null
    Add-Card $Slide ($Left+38) ($Top+154) 178 34 0xFFFFFF | Out-Null
    Add-TextBox $Slide "2  이OO  ·  접수 완료" ($Left+52) ($Top+164) 130 14 11 $colorMuted $false | Out-Null
    Add-Card $Slide ($Left+38) ($Top+198) 178 46 0xEEF0E4 | Out-Null
    Add-TextBox $Slide "Notices / Reservations" ($Left+52) ($Top+212) 136 16 11 $colorAccentDark $true | Out-Null
    Add-Card $Slide ($Left+248) ($Top+68) 112 84 0xFFF3E8 | Out-Null
    Add-TextBox $Slide "환자 앱" ($Left+274) ($Top+86) 62 18 13 $colorWarm $true | Out-Null
    Add-TextBox $Slide "내 대기 순번" ($Left+270) ($Top+112) 70 14 10 $colorMuted $false | Out-Null
    Add-TextBox $Slide "1번" ($Left+286) ($Top+128) 42 22 18 $colorInk $true | Out-Null
    Add-Card $Slide ($Left+248) ($Top+176) 112 70 0xE3ECF0 | Out-Null
    Add-TextBox $Slide "Supabase" ($Left+270) ($Top+194) 70 18 13 $colorAccentDark $true | Out-Null
    Add-TextBox $Slide "patients / queue / notices" ($Left+264) ($Top+218) 86 20 8 $colorMuted $false | Out-Null
  } elseif ($Kind -eq "ai") {
    Add-TextBox $Slide "AI Agent Console & Report" ($Left+22) ($Top+18) 260 24 16 $colorAccentDark $true | Out-Null
    Add-Card $Slide ($Left+24) ($Top+56) 160 218 0xF7FAFB | Out-Null
    Add-Card $Slide ($Left+38) ($Top+76) 132 34 0x171717 | Out-Null
    Add-TextBox $Slide "/report project" ($Left+48) ($Top+86) 88 14 10 0xFFFFFF $true | Out-Null
    Add-Card $Slide ($Left+38) ($Top+126) 132 34 0xEEF0E4 | Out-Null
    Add-TextBox $Slide "회의 요약" ($Left+52) ($Top+136) 70 14 11 $colorInk $true | Out-Null
    Add-Card $Slide ($Left+38) ($Top+172) 132 34 0xEEF0E4 | Out-Null
    Add-TextBox $Slide "Action Item" ($Left+52) ($Top+182) 78 14 11 $colorInk $true | Out-Null
    Add-Card $Slide ($Left+206) ($Top+56) 154 218 0xFFFFFF | Out-Null
    Add-TextBox $Slide "Final Report" ($Left+226) ($Top+78) 92 18 14 $colorWarm $true | Out-Null
    Add-TextBox $Slide "진행률 82%" ($Left+226) ($Top+112) 78 16 12 $colorInk $true | Out-Null
    Add-Card $Slide ($Left+226) ($Top+138) 96 10 0xE3ECF0 | Out-Null
    Add-Card $Slide ($Left+226) ($Top+160) 108 10 0xE3ECF0 | Out-Null
    Add-Card $Slide ($Left+226) ($Top+184) 76 10 0xE3ECF0 | Out-Null
    Add-TextBox $Slide "Risk / Contribution / Schedule" ($Left+226) ($Top+218) 110 28 10 $colorMuted $false | Out-Null
  } elseif ($Kind -eq "party") {
    Add-TextBox $Slide "4Party Mobile Screens" ($Left+22) ($Top+18) 220 24 16 $colorAccentDark $true | Out-Null
    Add-Card $Slide ($Left+34) ($Top+52) 136 228 0xF7FAFB | Out-Null
    Add-TextBox $Slide "코스 선택" ($Left+58) ($Top+72) 78 18 13 $colorWarm $true | Out-Null
    Add-Card $Slide ($Left+52) ($Top+106) 100 42 0xFFFFFF | Out-Null
    Add-TextBox $Slide "A 코스" ($Left+68) ($Top+118) 50 14 11 $colorInk $true | Out-Null
    Add-TextBox $Slide "기흥역 → 명지대" ($Left+66) ($Top+132) 72 12 8 $colorMuted $false | Out-Null
    Add-Card $Slide ($Left+52) ($Top+164) 100 42 0xFFFFFF | Out-Null
    Add-TextBox $Slide "시간 선택" ($Left+66) ($Top+176) 68 14 11 $colorInk $true | Out-Null
    Add-TextBox $Slide "오늘 오후" ($Left+68) ($Top+190) 60 12 8 $colorMuted $false | Out-Null
    Add-Card $Slide ($Left+218) ($Top+52) 136 228 0xF7FAFB | Out-Null
    Add-TextBox $Slide "모집 목록" ($Left+242) ($Top+72) 78 18 13 $colorWarm $true | Out-Null
    Add-Card $Slide ($Left+236) ($Top+106) 100 58 0xFFFFFF | Out-Null
    Add-TextBox $Slide "A코스 모집중" ($Left+248) ($Top+118) 76 14 10 $colorInk $true | Out-Null
    Add-TextBox $Slide "2/4명 · 참여하기" ($Left+248) ($Top+140) 78 12 9 $colorMuted $false | Out-Null
    Add-Card $Slide ($Left+236) ($Top+184) 100 58 0xFFFFFF | Out-Null
    Add-TextBox $Slide "오픈채팅" ($Left+260) ($Top+204) 58 14 11 $colorAccentDark $true | Out-Null
  } elseif ($Kind -eq "life") {
    Add-TextBox $Slide "Life Manager App Mockup" ($Left+22) ($Top+18) 240 24 16 $colorAccentDark $true | Out-Null
    Add-Card $Slide ($Left+36) ($Top+52) 136 228 0xF7FAFB | Out-Null
    Add-TextBox $Slide "오늘 기록" ($Left+62) ($Top+72) 72 18 13 $colorWarm $true | Out-Null
    Add-Card $Slide ($Left+54) ($Top+106) 100 30 0xFFFFFF | Out-Null
    Add-TextBox $Slide "수면 7.5h" ($Left+68) ($Top+114) 68 12 10 $colorInk $true | Out-Null
    Add-Card $Slide ($Left+54) ($Top+148) 100 30 0xFFFFFF | Out-Null
    Add-TextBox $Slide "공부 2h" ($Left+70) ($Top+156) 60 12 10 $colorInk $true | Out-Null
    Add-Card $Slide ($Left+54) ($Top+190) 100 30 0xFFFFFF | Out-Null
    Add-TextBox $Slide "만보기 8300" ($Left+66) ($Top+198) 70 12 10 $colorInk $true | Out-Null
    Add-Card $Slide ($Left+208) ($Top+52) 144 228 0xFFFFFF | Out-Null
    Add-TextBox $Slide "최근 7일" ($Left+238) ($Top+72) 72 18 13 $colorWarm $true | Out-Null
    $bars = @(56, 82, 38, 98, 66, 44, 72)
    for ($i=0; $i -lt 7; $i++) {
      $bx = $Left + 226 + ($i * 15)
      $bh = $bars[$i]
      Add-Card $Slide $bx ($Top+220-$bh) 8 $bh 0xE3ECF0 | Out-Null
    }
    Add-TextBox $Slide "Room DB → SQLite 저장" ($Left+226) ($Top+242) 110 18 10 $colorMuted $false | Out-Null
  }
}
function Add-ProjectSlide {
  param(
    [string]$Number,
    [string]$Title,
    [string]$Subtitle,
    [string]$Period,
    [string]$Intro,
    [string[]]$Role,
    [string[]]$Features,
    [string[]]$Stack,
    [string]$ImagePath
  )
  $slide = New-Slide
  Add-Header $slide $Number $Title $Subtitle
  Add-Tag $slide $Period 54 170 150
  Add-TextBox $slide $Intro 54 205 370 76 14 $colorMuted $false | Out-Null
  $largeVisual = $ImagePath.Contains("slide-visual") -or $ImagePath.StartsWith("diagram:")
  if ($ImagePath.StartsWith("diagram:")) {
    Add-ReadableVisual $slide ($ImagePath.Substring(8)) 468 176 388 300 | Out-Null
  } elseif ($ImagePath.Contains(";")) {
    Add-ImageStrip $slide ($ImagePath -split ";") 468 176 388 218
  } elseif ($largeVisual) {
    Add-ImageSafe $slide $ImagePath 468 176 388 300 | Out-Null
  } else {
    Add-ImageSafe $slide $ImagePath 468 176 388 218 | Out-Null
  }
  Add-Card $slide 54 320 380 190 | Out-Null
  Add-TextBox $slide "담당 역할" 78 342 140 24 14 $colorWarm $true | Out-Null
  Add-BulletList $slide $Role 78 376 320 112 12
  if (-not $largeVisual) {
    Add-Card $slide 468 418 388 92 | Out-Null
    Add-TextBox $slide "구현 기능" 492 437 120 22 14 $colorWarm $true | Out-Null
    Add-BulletList $slide $Features 492 467 320 36 11
  }
  $x = 54
  foreach ($item in $Stack) {
    Add-Tag $slide $item $x 512 86
    $x += 94
  }
}

$s1 = New-Slide
Add-TextBox $s1 "PORTFOLIO" 54 38 220 28 14 $colorAccentDark $true | Out-Null
Add-TextBox $s1 "김나영" 54 102 260 62 46 $colorInk $true | Out-Null
Add-TextBox $s1 "Backend & AI Developer Portfolio" 54 174 540 34 24 $colorAccentDark $true | Out-Null
Add-TextBox $s1 "데이터 흐름과 서비스 구조를 이해하고, 백엔드와 AI 기능을 실제 서비스로 구현해 온 개발자입니다." 54 232 560 58 17 $colorMuted $false | Out-Null
Add-ImageSafe $s1 $profilePhoto 688 72 120 160 | Out-Null
Add-Card $s1 642 262 232 76 $colorSoft | Out-Null
Add-TextBox $s1 "4 Projects" 668 282 150 26 22 $colorAccentDark $true | Out-Null
Add-TextBox $s1 "Backend · AI · Android · Firebase" 668 312 170 18 11 $colorMuted $false | Out-Null
Add-Card $s1 642 362 232 78 $colorPanel | Out-Null
Add-TextBox $s1 "Core Stack" 668 382 140 24 18 $colorAccentDark $true | Out-Null
Add-TextBox $s1 "Python · PostgreSQL · Supabase · Firebase · Android" 668 410 172 24 11 $colorMuted $false | Out-Null
Add-TextBox $s1 "https://nadanaya.github.io/portfolio/" 54 470 520 24 14 $colorAccentDark $true | Out-Null
Add-TextBox $s1 "GitHub: github.com/nadanaya" 54 500 380 22 13 $colorMuted $false | Out-Null

$s2 = New-Slide
Add-Header $s2 "01 PROFILE" "데이터가 흐르는 구조를 구현합니다" "앱 화면, 클라우드 DB, AI Agent 흐름을 연결하며 서비스 데이터가 생성되고 저장되고 활용되는 과정을 다뤘습니다."
Add-Card $s2 54 186 250 250 | Out-Null
Add-TextBox $s2 "Backend" 78 212 160 30 22 $colorAccentDark $true | Out-Null
Add-BulletList $s2 @("Supabase와 PostgreSQL 기반 데이터 연동", "예약·대기열·공지사항 처리", "REST API 흐름과 예외 처리") 78 264 190 120 13
Add-Card $s2 332 186 250 250 | Out-Null
Add-TextBox $s2 "AI Agent" 356 212 160 30 22 $colorAccentDark $true | Out-Null
Add-BulletList $s2 @("Python 기반 Agent 백엔드 로직", "LangGraph Workflow", "보고서 생성과 fallback 처리") 356 264 190 120 13
Add-Card $s2 610 186 250 250 | Out-Null
Add-TextBox $s2 "App & Data" 634 212 170 30 22 $colorAccentDark $true | Out-Null
Add-BulletList $s2 @("Android, Kotlin, Java 경험", "Firebase Auth와 Firestore", "Room/SQLite 로컬 데이터 관리") 634 264 190 120 13
Add-TextBox $s2 "지원 방향: 백엔드 개발과 데이터 기반 서비스 구현 직무에서 안정적인 데이터 흐름과 협업 가능한 구조를 만드는 개발자" 54 478 800 38 15 $colorMuted $false | Out-Null

$sCert = New-Slide
Add-Header $sCert "02 EDUCATION & ACTIVITIES" "자격·교육·활동 이력을 한 장에 정리했습니다" "전공 학습, 자격 취득, AI·데이터 교육, 동아리와 대회 경험이 프로젝트 역량으로 이어졌습니다."
Add-Card $sCert 54 184 390 126 $colorPanel | Out-Null
Add-TextBox $sCert "Education" 80 206 150 28 22 $colorAccentDark $true | Out-Null
Add-TextBox $sCert "명지대학교 컴퓨터공학과 재학" 80 244 310 24 18 $colorInk $true | Out-Null
Add-TextBox $sCert "DB, Android, AI Agent 프로젝트 기반 전공 실습" 80 274 330 22 15 $colorMuted $false | Out-Null
Add-Card $sCert 516 184 390 126 $colorPanel | Out-Null
Add-TextBox $sCert "Certifications" 542 206 180 28 22 $colorAccentDark $true | Out-Null
Add-TextBox $sCert "ADsP · 한국데이터산업진흥원" 542 244 310 24 18 $colorInk $true | Out-Null
Add-TextBox $sCert "2025.09.05 취득 · 정보처리기사 필기 합격" 542 274 330 22 15 $colorMuted $false | Out-Null
Add-Card $sCert 54 336 390 146 $colorSoft | Out-Null
Add-TextBox $sCert "Training" 80 358 150 28 22 $colorAccentDark $true | Out-Null
Add-TextBox $sCert "BDA 학회 AI Agent 수업 · 2025" 80 394 310 24 17 $colorInk $true | Out-Null
Add-TextBox $sCert "HuggingFace · OpenAI · NLP · RAG 학습" 80 422 320 22 15 $colorMuted $false | Out-Null
Add-TextBox $sCert "HP Korea 멘토링 · 2025.05~09" 80 450 310 22 15 $colorAccentDark $true | Out-Null
Add-Card $sCert 516 336 390 146 $colorSoft | Out-Null
Add-TextBox $sCert "Club & Competition" 542 358 240 28 22 $colorAccentDark $true | Out-Null
Add-TextBox $sCert "MCC 백엔드·DB 스터디" 542 394 330 22 17 $colorInk $true | Out-Null
Add-TextBox $sCert "정보처리기사 스터디 조장 · 우수 스터디 조" 542 422 330 22 15 $colorMuted $false | Out-Null
Add-TextBox $sCert "특허전략 유니버시아드 · ICPC 참가" 542 450 330 22 15 $colorAccentDark $true | Out-Null
$s3 = New-Slide
Add-Header $s3 "03 PROJECT MAP" "프로젝트는 백엔드·AI·앱 데이터 경험으로 연결됩니다" "현재 공개 포트폴리오의 프로젝트 순서와 역할 설명을 기준으로 정리했습니다."
$map = @(
  @("01", "DentalLink", "치과 관리자 웹·환자 앱", "Supabase · PostgreSQL · REST API"),
  @("02", "AI Agent System", "회의 요약·일정·리포트 자동화", "Python · LangGraph · Discord Bot"),
  @("03", "4Party", "택시 동승 매칭 서비스", "Kotlin · Firebase Auth · Firestore"),
  @("04", "Life Manager", "생활 기록 Android 앱", "Java · Room · SQLite")
)
$top = 188
foreach ($row in $map) {
  Add-Card $s3 54 $top 804 62 | Out-Null
  Add-TextBox $s3 $row[0] 78 ($top + 18) 46 24 18 $colorAccentDark $true | Out-Null
  Add-TextBox $s3 $row[1] 138 ($top + 12) 170 28 18 $colorInk $true | Out-Null
  Add-TextBox $s3 $row[2] 330 ($top + 14) 260 24 13 $colorMuted $false | Out-Null
  Add-TextBox $s3 $row[3] 620 ($top + 14) 210 24 12 $colorAccentDark $true | Out-Null
  $top += 82
}

Add-ProjectSlide "04 DENTALLINK" "예약·대기 데이터를 하나로 연결했습니다" "Team Project · 치과 통합 관리 서비스" "2026.03 ~ 2026.06" "관리자 웹과 환자 앱이 같은 Supabase 데이터를 바라보도록 예약, 대기열, 환자 인증, 공지사항 흐름을 구현했습니다." @("Supabase 기반 데이터 구조 설계 및 연동", "환자·예약·대기열·공지사항 데이터 처리", "Flutter와 Supabase 간 조회·상태 변경 로직") @("대기 상태 변경", "PIN 인증", "공지 CRUD") @("Flutter","Dart","Supabase","PostgreSQL","REST API") "diagram:dental"

Add-ProjectSlide "05 AI AGENT" "팀 프로젝트 상태를 보고서로 정리합니다" "Team Project · 프로젝트 관리 AI Agent" "2026.02 ~ 2026.09" "Discord 명령으로 프로젝트 데이터를 받아 회의 요약, 액션 아이템, 일정 알림, 기여도 분석, 종료 리포트를 생성하는 흐름을 구현했습니다." @("Python 기반 Agent 백엔드 로직 구현", "Supabase SQL 스키마와 저장 구조 구성", "Discord Bot 명령과 Agent 실행 흐름 연동") @("회의 요약", "기여도 분석", "fallback 처리") @("Python","LangGraph","LLM","PostgreSQL","Discord") "diagram:ai"

Add-ProjectSlide "06 4PARTY" "Firebase 기반 실시간 매칭 경험" "Team Project · 택시 동승 매칭 서비스" "2025.09 ~ 2025.12" "기흥역과 명지대학교를 오가는 학생들의 택시 동승을 지원하는 Android 서비스로, 인증과 파티 생성·참여·조회 흐름을 구현했습니다." @("Firebase Authentication 기반 로그인 구현", "Cloud Firestore 데이터베이스 설계 및 연동", "파티 생성·조회·참여 기능 개발") @("동승 파티 생성", "실시간 목록", "오픈채팅 연결") @("Android","Kotlin","Firebase","Firestore","Git") "diagram:party"

Add-ProjectSlide "07 LIFE MANAGER" "Android 로컬 DB 구현 경험" "Team Project · 생활 기록 Android 앱" "2025.09 ~ 2025.12" "수면, 공부, 휴대폰 사용, 만보기 데이터를 입력·저장하고 최근 7일 그래프로 확인하는 Android 앱입니다." @("Android 앱 주요 화면 구성 및 기능 구현", "Room 기반 로컬 DB와 화면 데이터 연동", "사용자 입력값 검증과 예외 처리") @("생활 기록 저장", "7일 그래프", "Room Migration") @("Android","Java","Room","SQLite","XML") "diagram:life"

$s8 = New-Slide
Add-Header $s8 "08 SKILLS" "실제 프로젝트에 사용한 기술만 정리했습니다" "백엔드 지원 관점에서 기술을 나열하기보다, 어떤 역할에서 사용했는지 연결했습니다."
$groups = @(
  @("Backend", @("Python", "Java", "REST API", "Supabase")),
  @("Database", @("PostgreSQL", "Cloud Firestore", "Room", "SQLite")),
  @("AI", @("LangGraph", "LLM", "Markdown Report", "Fallback Handling")),
  @("App & Collaboration", @("Flutter", "Android", "Kotlin", "Git/GitHub"))
)
$lefts = @(54, 274, 494, 714)
for ($i=0; $i -lt $groups.Count; $i++) {
  Add-Card $s8 $lefts[$i] 194 190 230 | Out-Null
  Add-TextBox $s8 $groups[$i][0] ($lefts[$i]+20) 224 150 28 18 $colorAccentDark $true | Out-Null
  Add-BulletList $s8 $groups[$i][1] ($lefts[$i]+20) 274 142 110 13
}
Add-TextBox $s8 "핵심 강점: DB 구조를 이해하고, 앱·AI·백엔드 흐름을 연결해 실제 기능으로 구현하는 경험" 54 480 790 34 16 $colorMuted $false | Out-Null

$s9 = New-Slide
Add-Header $s9 "09 PROBLEM SOLVING" "문제 해결 경험을 면접 질문으로 연결할 수 있습니다" "프로젝트별 핵심 문제와 해결 방식을 한눈에 볼 수 있도록 정리했습니다."
$problems = @(
  @("DentalLink", "대기 상태 변경 후 순번 불일치", "최신 대기 목록 재조회와 상태별 표시 기준을 정리해 관리자/환자 화면의 기준을 맞춤"),
  @("AI Agent", "LLM 호출 실패 시 Bot 흐름 중단", "fallback 응답과 오류 상태 기록으로 다음 명령을 받을 수 있는 흐름 유지"),
  @("4Party", "실시간 목록과 참여 상태 동기화", "파티·사용자·탑승 정보를 분리하고 최신 목록 조회 기준을 정리"),
  @("Life Manager", "Room Migration으로 테이블 확장", "기존 생활 기록을 유지하면서 만보기 테이블을 추가")
)
$top = 184
foreach ($p in $problems) {
  Add-Card $s9 54 $top 804 72 | Out-Null
  Add-TextBox $s9 $p[0] 78 ($top+17) 126 24 15 $colorAccentDark $true | Out-Null
  Add-TextBox $s9 $p[1] 224 ($top+14) 220 24 13 $colorInk $true | Out-Null
  Add-TextBox $s9 $p[2] 464 ($top+12) 350 38 12 $colorMuted $false | Out-Null
  $top += 86
}

$s10 = New-Slide
Add-TextBox $s10 "THANK YOU" 54 88 520 68 46 $colorInk $true | Out-Null
Add-TextBox $s10 "데이터가 잘 흐르는 서비스를 만들겠습니다." 54 174 560 34 22 $colorAccentDark $true | Out-Null
Add-TextBox $s10 "김나영 / Backend & AI Developer Portfolio" 54 236 520 26 17 $colorMuted $false | Out-Null
Add-Card $s10 54 324 804 124 $colorPanel | Out-Null
Add-TextBox $s10 "Portfolio" 88 354 120 24 17 $colorWarm $true | Out-Null
Add-TextBox $s10 "https://nadanaya.github.io/portfolio/" 232 354 450 24 17 $colorAccentDark $true | Out-Null
Add-TextBox $s10 "GitHub" 88 398 120 24 17 $colorWarm $true | Out-Null
Add-TextBox $s10 "https://github.com/nadanaya" 232 398 450 24 17 $colorAccentDark $true | Out-Null
Add-TextBox $s10 "DentalLink · AI Agent System · 4Party · Life Manager" 54 494 660 28 16 $colorMuted $false | Out-Null

$presentation.SaveAs($OutputPath)
$presentation.Close()
$pp.Quit()

Write-Output $OutputPath
