# GitHub Issues 템플릿

이 파일은 GitHub Issues를 생성하기 위한 템플릿입니다. 각 Phase별로 아래 내용을 복사하여 GitHub Issues에 등록하세요.

---

## ✅ Issue #1: [Phase 1] 프로젝트 초기 설정
**Status**: Created ✓
**URL**: https://github.com/megaTRX/calculator/issues/1

---

## Issue #2: [Phase 2] 인프라 레이어 구현 (TDD)

### 작업 배경
계산기의 핵심 로직을 지원하기 위한 인프라 레이어(Storage, Evaluator)를 TDD 방식으로 구현합니다.

### 작업 내용
#### 2.1 Storage 인터페이스 및 구현
- [ ] IStorage 인터페이스 정의
- [ ] LocalStorageAdapter 구현 (TDD: RED-GREEN-REFACTOR)
- [ ] SessionStorageAdapter 구현 (TDD)
- [ ] MemoryStorage 구현 (TDD, 테스트용)

#### 2.2 Evaluator 인터페이스 및 구현
- [ ] IEvaluator 인터페이스 정의
- [ ] MathJsAdapter 구현 (TDD: RED-GREEN-REFACTOR)

### 인수 조건
- [ ] 모든 테스트 통과 (`npm test`)
- [ ] 테스트 커버리지 80% 이상
- [ ] SOLID 원칙 준수 (코드 리뷰 통과)
- [ ] LocalStorage, SessionStorage, Memory 모두 동일한 인터페이스로 사용 가능
- [ ] MathJsAdapter가 기본 수식을 정확히 평가함

**예상 소요 시간**: 2-3일  
**Labels**: `phase-2`, `tdd`, `infrastructure`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-2)

---

## Issue #3: [Phase 3] 계산기 핵심 로직 구현 (TDD)

### 작업 배경
계산기의 핵심 비즈니스 로직을 TDD 방식으로 구현합니다. 기본 산술 연산, 과학 함수, 각도 모드 등을 포함합니다.

### 작업 내용
#### 3.1 기본 Calculator 클래스
- [ ] Calculator 클래스 기본 구조 (TDD)
- [ ] 기본 산술 연산 (+, -, ×, ÷) (TDD)
- [ ] 오류 처리 (0으로 나누기, 잘못된 수식) (TDD)

#### 3.2 MathEvaluator 클래스
- [ ] 표현식 평가 로직 (TDD)
- [ ] Math.js 통합
- [ ] 단일 책임 원칙 적용

#### 3.3 각도 모드 (AngleMode)
- [ ] AngleModeStrategy 구현 (TDD)
- [ ] DegreeStrategy 구현
- [ ] RadianStrategy 구현
- [ ] 전략 패턴 적용 (개방-폐쇄 원칙)

#### 3.4 과학 함수
- [ ] 삼각함수 (sin, cos, tan) (TDD)
- [ ] 로그 함수 (ln, log) (TDD)
- [ ] 기타 함수 (sqrt, power) (TDD)
- [ ] 상수 (π, e) 지원

### 인수 조건
- [ ] 모든 테스트 통과 (`npm test`)
- [ ] 테스트 커버리지 80% 이상
- [ ] 기본 산술 연산 정상 동작
- [ ] 과학 함수 정상 동작
- [ ] DEG/RAD 모드 전환 정상 동작
- [ ] 오류 처리 정상 동작
- [ ] SOLID 원칙 준수 (특히 전략 패턴)

**예상 소요 시간**: 3-4일  
**Labels**: `phase-3`, `tdd`, `domain`, `core-logic`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-3)

---

## Issue #4: [Phase 4] 히스토리 관리 구현 (TDD)

### 작업 배경
계산 히스토리를 관리하고 LocalStorage에 저장/로드하는 기능을 TDD 방식으로 구현합니다.

### 작업 내용
#### 4.1 CalculationHistory 클래스
- [ ] 기본 히스토리 관리 (TDD)
- [ ] 히스토리 제한 (최대 50개) (TDD)
- [ ] 히스토리 조회 및 삭제 (TDD)
- [ ] 불변성 보장

#### 4.2 히스토리 저장소 통합
- [ ] HistoryStorage 클래스 (TDD)
- [ ] LocalStorageAdapter 사용
- [ ] 의존성 주입 패턴 적용

### 인수 조건
- [ ] 모든 테스트 통과 (`npm test`)
- [ ] 테스트 커버리지 80% 이상
- [ ] 히스토리 추가/조회/삭제 정상 동작
- [ ] 최대 50개 제한 정상 동작
- [ ] LocalStorage 저장/로드 정상 동작
- [ ] 의존성 주입 패턴 적용

**예상 소요 시간**: 1-2일  
**Labels**: `phase-4`, `tdd`, `domain`, `history`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-4)

---

## Issue #5: [Phase 5] 애플리케이션 레이어 구현 (TDD)

### 작업 배경
도메인 로직과 UI를 연결하는 애플리케이션 컨트롤러를 TDD 방식으로 구현합니다.

### 작업 내용
#### 5.1 CalculatorController
- [ ] 기본 컨트롤러 구현 (TDD)
  - [ ] 숫자 입력 처리
  - [ ] 연산자 입력 처리
  - [ ] 계산 실행
  - [ ] 지우기 기능
- [ ] 오류 처리 통합
- [ ] 의존성 주입, 단일 책임 원칙 적용

#### 5.2 HistoryController
- [ ] 히스토리 컨트롤러 구현 (TDD)
- [ ] Calculator와 History 조율

### 인수 조건
- [ ] 모든 테스트 통과 (`npm test`)
- [ ] 테스트 커버리지 80% 이상
- [ ] CalculatorController가 Calculator와 History를 올바르게 조율함
- [ ] 오류 처리가 사용자 친화적임
- [ ] 의존성 주입 패턴 적용

**예상 소요 시간**: 2일  
**Labels**: `phase-5`, `tdd`, `application`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-5)

---

## Issue #6: [Phase 6] UI 구현 (수동 테스트)

### 작업 배경
계산기의 사용자 인터페이스를 구현합니다.  
**⚠️ 중요**: UI는 자동화된 테스트를 작성하지 않고 수동으로 테스트합니다.

### 작업 내용
#### 6.1 HTML 마크업
- [ ] 헤더 (메뉴, 모드 전환, 히스토리)
- [ ] 디스플레이 영역 (수식, 결과)
- [ ] 컨트롤 바 (DEG/RAD, 백스페이스)
- [ ] 키패드 (과학 함수 행, 메인 그리드)
- [ ] 접근성 (ARIA 속성 추가)

#### 6.2 CSS 스타일링
- [ ] Tailwind 커스텀 설정 (색상, 폰트, 반응형)
- [ ] 커스텀 스타일 (애니메이션, 호버/액티브, 그림자)

#### 6.3 DisplayManager
- [ ] 수식 업데이트 메서드
- [ ] 결과 업데이트 메서드
- [ ] 숫자 포맷팅 (천 단위 구분)
- [ ] 오류 메시지 표시
- [ ] 애니메이션 효과

#### 6.4 EventHandler
- [ ] 버튼 클릭 이벤트 바인딩
- [ ] 키보드 입력 이벤트 처리
- [ ] 모드 전환 이벤트
- [ ] 히스토리 패널 토글

#### 6.5 수동 UI 테스트
- [ ] 모든 버튼 클릭 동작 확인
- [ ] 키보드 입력 동작 확인
- [ ] 디스플레이 업데이트 확인
- [ ] 애니메이션 효과 확인
- [ ] 반응형 레이아웃 확인

### 인수 조건
- [ ] 디자인 파일과 일치하는 UI 구현
- [ ] 모든 버튼 정상 동작 (수동 테스트)
- [ ] 키보드 단축키 정상 동작
- [ ] 반응형 디자인 (모바일/태블릿/데스크톱)
- [ ] 접근성 기준 준수 (ARIA)
- [ ] 애니메이션 부드럽게 동작 (60 FPS)

**예상 소요 시간**: 3-4일  
**Labels**: `phase-6`, `ui`, `manual-test`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-6), [디자인 참조](docs/stitch_design/)

---

## Issue #7: [Phase 7] 메인 앱 통합 (수동 테스트)

### 작업 배경
모든 컴포넌트를 통합하여 완전한 계산기 애플리케이션을 구성합니다.

### 작업 내용
#### 7.1 main.js 구현
- [ ] 의존성 주입 설정
- [ ] 이벤트 리스너 바인딩
- [ ] 초기 상태 로드 (LocalStorage)

#### 7.2 수동 통합 테스트
- [ ] 전체 계산 흐름 테스트
  - [ ] 숫자 입력 → 연산자 → 숫자 → 등호
  - [ ] 결과 표시 확인
  - [ ] 히스토리 저장 확인
- [ ] 과학 함수 동작 확인
- [ ] 각도 모드 전환 확인
- [ ] 오류 처리 확인
- [ ] LocalStorage 저장/로드 확인

### 인수 조건
- [ ] 모든 기능 통합되어 정상 동작
- [ ] 계산 흐름 끊김 없이 동작
- [ ] 히스토리 LocalStorage 저장/로드
- [ ] 페이지 새로고침 후 상태 유지
- [ ] 모든 수동 테스트 통과

**예상 소요 시간**: 1일  
**Labels**: `phase-7`, `integration`, `manual-test`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-7)

---

## Issue #8: [Phase 8] 단위 변환 기능 구현 (TDD, 선택사항)

### 작업 배경
계산기에 단위 변환 기능을 추가합니다.  
**⚠️ 우선순위**: 낮음 (v1.1 이후)

### 작업 내용
#### 8.1 UnitConverter 클래스 (TDD)
- [ ] 기본 변환 로직 (TDD)
- [ ] 다양한 카테고리 지원
  - [ ] 길이 (m, km, ft, in, mi)
  - [ ] 무게 (kg, g, lb, oz)
  - [ ] 온도 (°C, °F, K)
  - [ ] 부피 (L, mL, gal, cup)
  - [ ] 면적 (m², ft², acre)
  - [ ] 속도 (km/h, mph, m/s)
- [ ] ConversionStrategy 패턴 (TDD)
- [ ] 개방-폐쇄 원칙 적용

#### 8.2 UI 통합
- [ ] 단위 변환 모드 UI
- [ ] CALC/UNIT 모드 전환

### 인수 조건
- [ ] 모든 테스트 통과 (`npm test`)
- [ ] 테스트 커버리지 80% 이상
- [ ] 모든 카테고리 단위 변환 정확함
- [ ] CALC/UNIT 모드 전환 정상 동작
- [ ] 전략 패턴 적용

**예상 소요 시간**: 2-3일  
**Labels**: `phase-8`, `tdd`, `domain`, `enhancement`, `optional`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-8)

---

## Issue #9: [Phase 9] 테스트 및 품질 보증

### 작업 배경
배포 전 전체 애플리케이션의 품질을 보증하기 위한 종합 테스트를 수행합니다.

### 작업 내용
#### 9.1 테스트 커버리지 확인
- [ ] 커버리지 리포트 생성 (`npm run test:coverage`)
- [ ] 80% 이상 커버리지 확인
- [ ] 누락된 테스트 추가

#### 9.2 린팅 및 코드 품질
- [ ] ESLint 실행 (`npm run lint`)
- [ ] 린팅 오류 수정
- [ ] 코드 리뷰 체크리스트 확인

#### 9.3 브라우저 호환성 테스트
- [ ] Chrome (최신 버전)
- [ ] Firefox (최신 버전)
- [ ] Safari (최신 버전)
- [ ] Edge (최신 버전)
- [ ] 모바일 Safari (iOS)
- [ ] Chrome Mobile (Android)

#### 9.4 반응형 테스트
- [ ] 모바일 (320px - 767px)
- [ ] 태블릿 (768px - 1023px)
- [ ] 데스크톱 (1024px+)

#### 9.5 접근성 테스트
- [ ] WAVE 도구 검사
- [ ] 키보드 탐색 테스트
- [ ] 스크린 리더 테스트 (NVDA/JAWS)
- [ ] 색상 대비 확인

#### 9.6 성능 테스트
- [ ] Lighthouse 점수 확인
  - Performance: 90+
  - Accessibility: 90+
  - Best Practices: 90+
  - SEO: 90+
- [ ] 번들 크기 확인 (< 500KB)
- [ ] 로드 시간 확인 (< 2초)

### 인수 조건
- [ ] 코어 로직 테스트 커버리지 80% 이상
- [ ] 모든 린팅 오류 해결
- [ ] 모든 주요 브라우저 정상 동작
- [ ] 모든 화면 크기 정상 동작
- [ ] WCAG 2.1 Level AA 준수
- [ ] Lighthouse 점수 모두 90+ 달성

**예상 소요 시간**: 2-3일  
**Labels**: `phase-9`, `testing`, `qa`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-9)

---

## Issue #10: [Phase 10] 배포 및 문서화

### 작업 배경
완성된 애플리케이션을 GitHub Pages에 배포하고 최종 문서를 정리합니다.

### 작업 내용
#### 10.1 GitHub 저장소 설정
- [ ] README.md 업데이트
  - [ ] 사용자명 변경
  - [ ] 스크린샷 추가
  - [ ] 데모 링크 업데이트
- [ ] LICENSE 파일 추가
- [ ] CONTRIBUTING.md 작성 (선택사항)

#### 10.2 GitHub Pages 배포
- [ ] 코드 푸시
- [ ] GitHub Pages 설정 (Settings → Pages → Source: GitHub Actions)
- [ ] 배포 확인

#### 10.3 CI/CD 확인
- [ ] GitHub Actions 워크플로우 실행 확인
- [ ] 테스트 자동 실행 확인
- [ ] 배포 자동화 확인

#### 10.4 문서 최종 검토
- [ ] PRD.md 검토
- [ ] TECH_SPEC.md 검토
- [ ] DEVELOPMENT_GUIDE.md 검토
- [ ] API 문서 작성 (선택사항)

### 인수 조건
- [ ] GitHub Pages 정상 배포
- [ ] 배포된 사이트 정상 동작
- [ ] GitHub Actions 자동 실행
- [ ] README.md 완성
- [ ] 모든 문서 최신 상태

**예상 소요 시간**: 1-2일  
**Labels**: `phase-10`, `deployment`, `documentation`  
**관련 문서**: [IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md#phase-10), [README.md](README.md)

---

## 이슈 생성 방법

1. GitHub 저장소로 이동: https://github.com/megaTRX/calculator
2. Issues 탭 클릭
3. "New issue" 버튼 클릭
4. 위 템플릿에서 해당 Phase의 내용을 복사하여 붙여넣기
5. Title과 Body를 설정
6. Labels 추가 (해당하는 경우)
7. Assignee 설정
8. "Submit new issue" 클릭

또는 GitHub CLI 사용:
```bash
gh issue create --title "[Phase X] 제목" --body "내용" --assignee "@me"
```
