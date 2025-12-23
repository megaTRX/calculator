# GitHub Issues Creation Script
# This script creates GitHub issues for the calculator project

# Phase 1: Project Setup
gh issue create --title "[Phase 1] 프로젝트 초기 설정" --body "## 작업 배경
프로젝트 개발을 시작하기 위한 기본 환경 설정이 필요합니다.

## 작업 내용
### 1.1 개발 환경 설정
- [ ] Node.js 및 npm 설치 확인
- [ ] 의존성 설치 (\`npm install\`)
- [ ] Git 저장소 초기화 및 원격 저장소 연결
- [ ] 개발 서버 실행 확인 (\`npm run dev\`)

### 1.2 디렉토리 구조 생성
- [ ] \`src/js/domain/\` 디렉토리 생성 (calculator/, history/, unit-converter/)
- [ ] \`src/js/infrastructure/\` 디렉토리 생성 (storage/, evaluator/)
- [ ] \`src/js/application/\` 디렉토리 생성
- [ ] \`src/js/presentation/\` 디렉토리 생성
- [ ] \`src/css/\` 디렉토리 생성

### 1.3 기본 HTML 구조 생성
- [ ] \`index.html\` 작성
- [ ] Meta 태그 설정 (SEO, 반응형)
- [ ] 외부 리소스 로드 (Tailwind CSS, Google Fonts, Material Icons)
- [ ] Tailwind 설정 스크립트
- [ ] 기본 레이아웃 구조

## 인수 조건
- [ ] \`npm run dev\` 실행 시 개발 서버가 정상적으로 시작됨
- [ ] 모든 디렉토리 구조가 생성됨
- [ ] \`index.html\`이 브라우저에서 정상적으로 렌더링됨
- [ ] Tailwind CSS가 적용됨

## 예상 소요 시간
1-2일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-1-프로젝트-초기-설정-1-2일)
" --label "phase-1,setup" --assignee "@me"

# Phase 2: Infrastructure Layer
gh issue create --title "[Phase 2] 인프라 레이어 구현 (TDD)" --body "## 작업 배경
계산기의 핵심 로직을 지원하기 위한 인프라 레이어(Storage, Evaluator)를 TDD 방식으로 구현합니다.

## 작업 내용
### 2.1 Storage 인터페이스 및 구현
#### 2.1.1 IStorage 인터페이스 정의
- [ ] 테스트 작성: \`src/js/infrastructure/storage/__tests__/IStorage.test.js\`
- [ ] 구현: \`src/js/infrastructure/storage/IStorage.js\`

#### 2.1.2 LocalStorageAdapter 구현 (TDD)
- [ ] RED: 실패하는 테스트 작성
- [ ] GREEN: 테스트 통과하는 최소 코드 작성
- [ ] REFACTOR: SOLID 원칙 적용
- [ ] 파일: \`src/js/infrastructure/storage/LocalStorageAdapter.js\`

#### 2.1.3 SessionStorageAdapter 구현 (TDD)
- [ ] 테스트 작성 및 구현
- [ ] 파일: \`src/js/infrastructure/storage/SessionStorageAdapter.js\`

#### 2.1.4 MemoryStorage 구현 (TDD)
- [ ] 테스트 작성 및 구현 (테스트용)
- [ ] 파일: \`src/js/infrastructure/storage/MemoryStorage.js\`

### 2.2 Evaluator 인터페이스 및 구현
#### 2.2.1 IEvaluator 인터페이스 정의
- [ ] 테스트 작성: \`src/js/infrastructure/evaluator/__tests__/IEvaluator.test.js\`
- [ ] 구현: \`src/js/infrastructure/evaluator/IEvaluator.js\`

#### 2.2.2 MathJsAdapter 구현 (TDD)
- [ ] RED: 실패하는 테스트 작성
- [ ] GREEN: Math.js를 사용한 구현
- [ ] REFACTOR: 오류 처리 개선
- [ ] 파일: \`src/js/infrastructure/evaluator/MathJsAdapter.js\`

## 인수 조건
- [ ] 모든 테스트가 통과함 (\`npm test\`)
- [ ] 테스트 커버리지 80% 이상
- [ ] SOLID 원칙 준수 (코드 리뷰 통과)
- [ ] LocalStorage, SessionStorage, Memory 모두 동일한 인터페이스로 사용 가능
- [ ] MathJsAdapter가 기본 수식을 정확히 평가함

## 예상 소요 시간
2-3일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-2-인프라-레이어-구현-tdd-2-3일)
- [DEVELOPMENT_GUIDE.md](docs/DEVELOPMENT_GUIDE.md#2-tdd-test-driven-development)
" --label "phase-2,tdd,infrastructure" --assignee "@me"

# Phase 3: Domain Layer - Calculator Core Logic
gh issue create --title "[Phase 3] 계산기 핵심 로직 구현 (TDD)" --body "## 작업 배경
계산기의 핵심 비즈니스 로직을 TDD 방식으로 구현합니다. 기본 산술 연산, 과학 함수, 각도 모드 등을 포함합니다.

## 작업 내용
### 3.1 기본 Calculator 클래스
#### 3.1.1 Calculator 클래스 기본 구조 (TDD)
- [ ] RED: 테스트 작성
- [ ] GREEN: 최소 구현
- [ ] REFACTOR: 의존성 주입 적용
- [ ] 파일: \`src/js/domain/calculator/Calculator.js\`

#### 3.1.2 기본 산술 연산 (TDD)
- [ ] RED: 덧셈, 뺄셈, 곱셈, 나눗셈 테스트
- [ ] GREEN: 구현
- [ ] REFACTOR: 코드 정리

#### 3.1.3 오류 처리 (TDD)
- [ ] RED: 0으로 나누기 테스트
- [ ] GREEN: 오류 처리 구현
- [ ] RED: 잘못된 수식 테스트
- [ ] GREEN: 검증 로직 구현

### 3.2 MathEvaluator 클래스
- [ ] RED: 표현식 평가 테스트
- [ ] GREEN: Math.js 통합
- [ ] REFACTOR: 단일 책임 원칙 적용
- [ ] 파일: \`src/js/domain/calculator/MathEvaluator.js\`

### 3.3 각도 모드 (AngleMode)
#### 3.3.1 AngleModeStrategy 구현 (TDD)
- [ ] RED: DEG 모드 테스트 (sin(30) = 0.5)
- [ ] GREEN: DegreeStrategy 구현
- [ ] RED: RAD 모드 테스트
- [ ] GREEN: RadianStrategy 구현
- [ ] REFACTOR: 전략 패턴 적용 (개방-폐쇄 원칙)
- [ ] 파일: \`src/js/domain/calculator/AngleModeStrategy.js\`

### 3.4 과학 함수
#### 3.4.1 삼각함수 (TDD)
- [ ] RED: sin, cos, tan 테스트
- [ ] GREEN: 구현
- [ ] REFACTOR: 각도 모드 통합

#### 3.4.2 로그 함수 (TDD)
- [ ] RED: ln, log 테스트
- [ ] GREEN: 구현

#### 3.4.3 기타 함수 (TDD)
- [ ] RED: sqrt, power 테스트
- [ ] GREEN: 구현
- [ ] 상수 (π, e) 지원

## 인수 조건
- [ ] 모든 테스트가 통과함 (\`npm test\`)
- [ ] 테스트 커버리지 80% 이상
- [ ] 기본 산술 연산 (+, -, ×, ÷) 정상 동작
- [ ] 과학 함수 (sin, cos, tan, ln, log, √) 정상 동작
- [ ] DEG/RAD 모드 전환 정상 동작
- [ ] 0으로 나누기 등 오류 처리 정상 동작
- [ ] SOLID 원칙 준수 (특히 전략 패턴)

## 예상 소요 시간
3-4일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-3-도메인-레이어---계산기-핵심-로직-tdd-3-4일)
- [DEVELOPMENT_GUIDE.md](docs/DEVELOPMENT_GUIDE.md#3-solid-원칙)
" --label "phase-3,tdd,domain,core-logic" --assignee "@me"

# Phase 4: Domain Layer - History Management
gh issue create --title "[Phase 4] 히스토리 관리 구현 (TDD)" --body "## 작업 배경
계산 히스토리를 관리하고 LocalStorage에 저장/로드하는 기능을 TDD 방식으로 구현합니다.

## 작업 내용
### 4.1 CalculationHistory 클래스
#### 4.1.1 기본 히스토리 관리 (TDD)
- [ ] RED: 히스토리 추가 테스트
- [ ] GREEN: 구현
- [ ] 파일: \`src/js/domain/history/CalculationHistory.js\`

#### 4.1.2 히스토리 제한 (TDD)
- [ ] RED: 최대 50개 제한 테스트
- [ ] GREEN: 구현

#### 4.1.3 히스토리 조회 및 삭제 (TDD)
- [ ] RED: 전체 조회, 개별 조회, 삭제 테스트
- [ ] GREEN: 구현
- [ ] REFACTOR: 불변성 보장

### 4.2 히스토리 저장소 통합
#### 4.2.1 HistoryStorage 클래스 (TDD)
- [ ] RED: 저장/로드 테스트
- [ ] GREEN: LocalStorageAdapter 사용
- [ ] REFACTOR: 의존성 주입
- [ ] 파일: \`src/js/domain/history/HistoryStorage.js\`

## 인수 조건
- [ ] 모든 테스트가 통과함 (\`npm test\`)
- [ ] 테스트 커버리지 80% 이상
- [ ] 히스토리 추가/조회/삭제 정상 동작
- [ ] 최대 50개 제한 정상 동작
- [ ] LocalStorage에 저장/로드 정상 동작
- [ ] 의존성 주입 패턴 적용

## 예상 소요 시간
1-2일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-4-도메인-레이어---히스토리-관리-tdd-1-2일)
" --label "phase-4,tdd,domain,history" --assignee "@me"

# Phase 5: Application Layer
gh issue create --title "[Phase 5] 애플리케이션 레이어 구현 (TDD)" --body "## 작업 배경
도메인 로직과 UI를 연결하는 애플리케이션 컨트롤러를 TDD 방식으로 구현합니다.

## 작업 내용
### 5.1 CalculatorController
#### 5.1.1 기본 컨트롤러 구현 (TDD)
- [ ] RED: 컨트롤러 테스트 (숫자 입력, 연산자 입력, 계산, 지우기)
- [ ] GREEN: 구현
- [ ] REFACTOR: 의존성 주입, 단일 책임
- [ ] 파일: \`src/js/application/CalculatorController.js\`

#### 5.1.2 오류 처리 통합
- [ ] RED: 오류 처리 테스트
- [ ] GREEN: 사용자 친화적 오류 메시지

### 5.2 HistoryController
#### 5.2.1 히스토리 컨트롤러 (TDD)
- [ ] RED: 히스토리 관리 테스트
- [ ] GREEN: 구현
- [ ] 파일: \`src/js/application/HistoryController.js\`

## 인수 조건
- [ ] 모든 테스트가 통과함 (\`npm test\`)
- [ ] 테스트 커버리지 80% 이상
- [ ] CalculatorController가 Calculator와 History를 올바르게 조율함
- [ ] 오류 처리가 사용자 친화적임
- [ ] 의존성 주입 패턴 적용

## 예상 소요 시간
2일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-5-애플리케이션-레이어-tdd-2일)
" --label "phase-5,tdd,application" --assignee "@me"

# Phase 6: UI Implementation
gh issue create --title "[Phase 6] UI 구현 (수동 테스트)" --body "## 작업 배경
계산기의 사용자 인터페이스를 구현합니다. **UI는 자동화된 테스트를 작성하지 않고 수동으로 테스트합니다.**

## 작업 내용
### 6.1 HTML 마크업
#### 6.1.1 계산기 레이아웃
- [ ] 헤더 (메뉴, 모드 전환, 히스토리)
- [ ] 디스플레이 영역 (수식, 결과)
- [ ] 컨트롤 바 (DEG/RAD, 백스페이스)
- [ ] 키패드 (과학 함수 행, 메인 그리드)

#### 6.1.2 접근성 (ARIA)
- [ ] 모든 버튼에 \`aria-label\` 추가
- [ ] 결과 디스플레이에 \`role=\"status\"\` 추가
- [ ] 오류 메시지에 \`role=\"alert\"\` 추가
- [ ] 키보드 탐색 순서 확인

### 6.2 CSS 스타일링
#### 6.2.1 Tailwind 커스텀 설정
- [ ] 색상 팔레트 정의
- [ ] 폰트 설정
- [ ] 반응형 브레이크포인트

#### 6.2.2 커스텀 스타일
- [ ] \`src/css/custom.css\` 작성
- [ ] 애니메이션 효과
- [ ] 호버/액티브 상태
- [ ] 그림자 및 그라디언트

### 6.3 DisplayManager
- [ ] 파일: \`src/js/presentation/DisplayManager.js\`
- [ ] 수식 업데이트 메서드
- [ ] 결과 업데이트 메서드
- [ ] 숫자 포맷팅 (천 단위 구분)
- [ ] 오류 메시지 표시
- [ ] 애니메이션 효과

### 6.4 EventHandler
- [ ] 파일: \`src/js/presentation/EventHandler.js\`
- [ ] 버튼 클릭 이벤트 바인딩
- [ ] 키보드 입력 이벤트 처리
- [ ] 모드 전환 이벤트
- [ ] 히스토리 패널 토글

### 6.5 수동 UI 테스트
- [ ] 모든 버튼 클릭 동작 확인
- [ ] 키보드 입력 동작 확인
- [ ] 디스플레이 업데이트 확인
- [ ] 애니메이션 효과 확인
- [ ] 반응형 레이아웃 확인

## 인수 조건
- [ ] 디자인 파일과 일치하는 UI 구현
- [ ] 모든 버튼이 정상적으로 동작함 (수동 테스트)
- [ ] 키보드 단축키가 정상적으로 동작함
- [ ] 반응형 디자인이 모바일/태블릿/데스크톱에서 정상 동작
- [ ] 접근성 기준 준수 (ARIA 속성)
- [ ] 애니메이션이 부드럽게 동작함 (60 FPS)

## 예상 소요 시간
3-4일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-6-ui-구현-3-4일)
- [디자인 참조](docs/stitch_design/)
" --label "phase-6,ui,manual-test" --assignee "@me"

# Phase 7: Main App Integration
gh issue create --title "[Phase 7] 메인 앱 통합 (수동 테스트)" --body "## 작업 배경
모든 컴포넌트를 통합하여 완전한 계산기 애플리케이션을 구성합니다.

## 작업 내용
### 7.1 main.js 구현
#### 7.1.1 앱 초기화
- [ ] 파일: \`src/js/main.js\`
- [ ] 의존성 주입 설정
- [ ] 이벤트 리스너 바인딩
- [ ] 초기 상태 로드 (LocalStorage)

#### 7.1.2 수동 통합 테스트
- [ ] 전체 계산 흐름 수동 테스트
  - [ ] 숫자 입력 → 연산자 → 숫자 → 등호
  - [ ] 결과 표시 확인
  - [ ] 히스토리 저장 확인
- [ ] 과학 함수 동작 확인
- [ ] 각도 모드 전환 확인
- [ ] 오류 처리 확인
- [ ] LocalStorage 저장/로드 확인

## 인수 조건
- [ ] 모든 기능이 통합되어 정상 동작함
- [ ] 계산 흐름이 끊김 없이 동작함
- [ ] 히스토리가 LocalStorage에 저장/로드됨
- [ ] 페이지 새로고침 후에도 상태 유지됨
- [ ] 모든 수동 테스트 통과

## 예상 소요 시간
1일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-7-메인-앱-통합-1일)
" --label "phase-7,integration,manual-test" --assignee "@me"

# Phase 8: Unit Converter (Optional)
gh issue create --title "[Phase 8] 단위 변환 기능 구현 (TDD, 선택사항)" --body "## 작업 배경
계산기에 단위 변환 기능을 추가합니다. 이 Phase는 선택사항입니다.

## 작업 내용
### 8.1 UnitConverter 클래스 (TDD)
#### 8.1.1 기본 변환 로직
- [ ] RED: 길이 변환 테스트
- [ ] GREEN: 구현
- [ ] 파일: \`src/js/domain/unit-converter/UnitConverter.js\`

#### 8.1.2 다양한 카테고리 지원
- [ ] 길이 (m, km, ft, in, mi)
- [ ] 무게 (kg, g, lb, oz)
- [ ] 온도 (°C, °F, K)
- [ ] 부피 (L, mL, gal, cup)
- [ ] 면적 (m², ft², acre)
- [ ] 속도 (km/h, mph, m/s)

#### 8.1.3 ConversionStrategy 패턴 (TDD)
- [ ] RED: 전략 패턴 테스트
- [ ] GREEN: 구현
- [ ] REFACTOR: 개방-폐쇄 원칙 적용
- [ ] 파일: \`src/js/domain/unit-converter/ConversionStrategy.js\`

### 8.2 UI 통합
- [ ] 단위 변환 모드 UI
- [ ] CALC/UNIT 모드 전환

## 인수 조건
- [ ] 모든 테스트가 통과함 (\`npm test\`)
- [ ] 테스트 커버리지 80% 이상
- [ ] 모든 카테고리의 단위 변환이 정확함
- [ ] CALC/UNIT 모드 전환이 정상 동작함
- [ ] 전략 패턴 적용 (개방-폐쇄 원칙)

## 예상 소요 시간
2-3일

## 우선순위
낮음 (v1.1 이후)

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-8-단위-변환-기능-선택사항-2-3일)
" --label "phase-8,tdd,domain,enhancement,optional" --assignee "@me"

# Phase 9: Testing and QA
gh issue create --title "[Phase 9] 테스트 및 품질 보증" --body "## 작업 배경
배포 전 전체 애플리케이션의 품질을 보증하기 위한 종합 테스트를 수행합니다.

## 작업 내용
### 9.1 테스트 커버리지 확인
- [ ] 커버리지 리포트 생성 (\`npm run test:coverage\`)
- [ ] 80% 이상 커버리지 확인
- [ ] 누락된 테스트 추가

### 9.2 린팅 및 코드 품질
- [ ] ESLint 실행 (\`npm run lint\`)
- [ ] 린팅 오류 수정
- [ ] 코드 리뷰 체크리스트 확인

### 9.3 브라우저 호환성 테스트
- [ ] Chrome (최신 버전)
- [ ] Firefox (최신 버전)
- [ ] Safari (최신 버전)
- [ ] Edge (최신 버전)
- [ ] 모바일 Safari (iOS)
- [ ] Chrome Mobile (Android)

### 9.4 반응형 테스트
- [ ] 모바일 (320px - 767px)
- [ ] 태블릿 (768px - 1023px)
- [ ] 데스크톱 (1024px+)

### 9.5 접근성 테스트
- [ ] WAVE 도구 검사
- [ ] 키보드 탐색 테스트
- [ ] 스크린 리더 테스트 (NVDA/JAWS)
- [ ] 색상 대비 확인

### 9.6 성능 테스트
- [ ] Lighthouse 점수 확인
  - Performance: 90+
  - Accessibility: 90+
  - Best Practices: 90+
  - SEO: 90+
- [ ] 번들 크기 확인 (< 500KB)
- [ ] 로드 시간 확인 (< 2초)

## 인수 조건
- [ ] 코어 로직 테스트 커버리지 80% 이상
- [ ] 모든 린팅 오류 해결
- [ ] 모든 주요 브라우저에서 정상 동작
- [ ] 모든 화면 크기에서 정상 동작
- [ ] WCAG 2.1 Level AA 준수
- [ ] Lighthouse 점수 모두 90+ 달성

## 예상 소요 시간
2-3일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-9-테스트-및-품질-보증-2-3일)
" --label "phase-9,testing,qa" --assignee "@me"

# Phase 10: Deployment and Documentation
gh issue create --title "[Phase 10] 배포 및 문서화" --body "## 작업 배경
완성된 애플리케이션을 GitHub Pages에 배포하고 최종 문서를 정리합니다.

## 작업 내용
### 10.1 GitHub 저장소 설정
- [ ] README.md 업데이트
  - [ ] \`YOUR_USERNAME\` 실제 사용자명으로 변경
  - [ ] 스크린샷 추가
  - [ ] 데모 링크 업데이트
- [ ] LICENSE 파일 추가
- [ ] CONTRIBUTING.md 작성 (선택사항)

### 10.2 GitHub Pages 배포
- [ ] GitHub 저장소 생성 (이미 완료)
- [ ] 코드 푸시
- [ ] GitHub Pages 설정 (Settings → Pages → Source: GitHub Actions)
- [ ] 배포 확인

### 10.3 CI/CD 확인
- [ ] GitHub Actions 워크플로우 실행 확인
- [ ] 테스트 자동 실행 확인
- [ ] 배포 자동화 확인

### 10.4 문서 최종 검토
- [ ] PRD.md 검토
- [ ] TECH_SPEC.md 검토
- [ ] DEVELOPMENT_GUIDE.md 검토
- [ ] API 문서 작성 (선택사항)

## 인수 조건
- [ ] GitHub Pages에 정상적으로 배포됨
- [ ] 배포된 사이트가 정상 동작함
- [ ] GitHub Actions가 자동으로 실행됨
- [ ] README.md가 완성됨
- [ ] 모든 문서가 최신 상태임

## 예상 소요 시간
1-2일

## 관련 문서
- [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-10-배포-및-문서화-1-2일)
- [README.md](README.md)
" --label "phase-10,deployment,documentation" --assignee "@me"

Write-Host "GitHub issues creation script completed!"
Write-Host "Run this script with: powershell -ExecutionPolicy Bypass -File create-issues.ps1"
