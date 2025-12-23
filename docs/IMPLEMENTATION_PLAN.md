# 구현 계획 (Implementation Plan)
# 공학용 계산기 웹 애플리케이션

## 📋 프로젝트 개요

이 문서는 공학용 계산기 웹 애플리케이션의 구현 작업을 단계별로 세분화한 계획서입니다.

**개발 원칙:**
- ✅ TDD (Test-Driven Development) - 코어 로직은 테스트 먼저 작성
- ✅ SOLID 원칙 준수
- ✅ GitHub Actions를 통한 CI/CD
- ✅ GitHub Pages 배포

---

## Phase 1: 프로젝트 초기 설정 (1-2일)

### 1.1 개발 환경 설정
- [ ] Node.js 및 npm 설치 확인
- [ ] 의존성 설치
  ```bash
  npm install
  ```
- [ ] Git 저장소 초기화 및 원격 저장소 연결
  ```bash
  git init
  git remote add origin https://github.com/YOUR_USERNAME/calculator.git
  ```
- [ ] 개발 서버 실행 확인
  ```bash
  npm run dev
  ```

### 1.2 디렉토리 구조 생성
- [ ] `src/js/domain/` 디렉토리 생성
  - [ ] `calculator/`
  - [ ] `history/`
  - [ ] `unit-converter/`
- [ ] `src/js/infrastructure/` 디렉토리 생성
  - [ ] `storage/`
  - [ ] `evaluator/`
- [ ] `src/js/application/` 디렉토리 생성
- [ ] `src/js/presentation/` 디렉토리 생성
- [ ] `src/css/` 디렉토리 생성

### 1.3 기본 HTML 구조 생성
- [ ] `index.html` 작성
  - [ ] Meta 태그 설정 (SEO, 반응형)
  - [ ] 외부 리소스 로드 (Tailwind CSS, Google Fonts, Material Icons)
  - [ ] Tailwind 설정 스크립트
  - [ ] 기본 레이아웃 구조

**예상 소요 시간:** 1-2일

---

## Phase 2: 인프라 레이어 구현 (TDD) (2-3일)

### 2.1 Storage 인터페이스 및 구현

#### 2.1.1 IStorage 인터페이스 정의
- [ ] **테스트 작성**: `src/js/infrastructure/storage/__tests__/IStorage.test.js`
  ```javascript
  describe('IStorage Interface', () => {
    test('should define save method', () => {});
    test('should define load method', () => {});
  });
  ```
- [ ] **구현**: `src/js/infrastructure/storage/IStorage.js`
  ```javascript
  export class IStorage {
    save(key, value) { throw new Error('Must be implemented'); }
    load(key) { throw new Error('Must be implemented'); }
  }
  ```

#### 2.1.2 LocalStorageAdapter 구현 (TDD)
- [ ] **RED**: 실패하는 테스트 작성
  ```javascript
  describe('LocalStorageAdapter', () => {
    test('should save data to localStorage', () => {});
    test('should load data from localStorage', () => {});
    test('should return null if key does not exist', () => {});
  });
  ```
- [ ] **GREEN**: 테스트 통과하는 최소 코드 작성
- [ ] **REFACTOR**: SOLID 원칙 적용
- [ ] **파일**: `src/js/infrastructure/storage/LocalStorageAdapter.js`

#### 2.1.3 SessionStorageAdapter 구현 (TDD)
- [ ] 테스트 작성 및 구현
- [ ] **파일**: `src/js/infrastructure/storage/SessionStorageAdapter.js`

#### 2.1.4 MemoryStorage 구현 (TDD)
- [ ] 테스트 작성 및 구현 (테스트용)
- [ ] **파일**: `src/js/infrastructure/storage/MemoryStorage.js`

### 2.2 Evaluator 인터페이스 및 구현

#### 2.2.1 IEvaluator 인터페이스 정의
- [ ] **테스트 작성**: `src/js/infrastructure/evaluator/__tests__/IEvaluator.test.js`
- [ ] **구현**: `src/js/infrastructure/evaluator/IEvaluator.js`

#### 2.2.2 MathJsAdapter 구현 (TDD)
- [ ] **RED**: 실패하는 테스트 작성
  ```javascript
  describe('MathJsAdapter', () => {
    test('should evaluate simple expression', () => {
      const evaluator = new MathJsAdapter();
      expect(evaluator.evaluate('5 + 3')).toBe(8);
    });
    test('should handle division by zero', () => {});
    test('should evaluate scientific functions', () => {});
  });
  ```
- [ ] **GREEN**: Math.js를 사용한 구현
- [ ] **REFACTOR**: 오류 처리 개선
- [ ] **파일**: `src/js/infrastructure/evaluator/MathJsAdapter.js`

**예상 소요 시간:** 2-3일

---

## Phase 3: 도메인 레이어 - 계산기 핵심 로직 (TDD) (3-4일)

### 3.1 기본 Calculator 클래스

#### 3.1.1 Calculator 클래스 기본 구조 (TDD)
- [ ] **RED**: 테스트 작성
  ```javascript
  describe('Calculator - 기본 기능', () => {
    test('should initialize with empty expression', () => {});
    test('should accept input', () => {});
    test('should clear expression', () => {});
  });
  ```
- [ ] **GREEN**: 최소 구현
- [ ] **REFACTOR**: 의존성 주입 적용
- [ ] **파일**: `src/js/domain/calculator/Calculator.js`

#### 3.1.2 기본 산술 연산 (TDD)
- [ ] **RED**: 덧셈 테스트
  ```javascript
  test('should add two numbers', () => {
    calculator.input('5 + 3');
    expect(calculator.calculate()).toBe(8);
  });
  ```
- [ ] **GREEN**: 구현
- [ ] **RED**: 뺄셈, 곱셈, 나눗셈 테스트
- [ ] **GREEN**: 구현
- [ ] **REFACTOR**: 코드 정리

#### 3.1.3 오류 처리 (TDD)
- [ ] **RED**: 0으로 나누기 테스트
  ```javascript
  test('should throw error when dividing by zero', () => {
    calculator.input('5 / 0');
    expect(() => calculator.calculate()).toThrow('0으로 나눌 수 없습니다');
  });
  ```
- [ ] **GREEN**: 오류 처리 구현
- [ ] **RED**: 잘못된 수식 테스트
- [ ] **GREEN**: 검증 로직 구현

### 3.2 MathEvaluator 클래스

#### 3.2.1 MathEvaluator 기본 구현 (TDD)
- [ ] **RED**: 표현식 평가 테스트
- [ ] **GREEN**: Math.js 통합
- [ ] **REFACTOR**: 단일 책임 원칙 적용
- [ ] **파일**: `src/js/domain/calculator/MathEvaluator.js`

### 3.3 각도 모드 (AngleMode)

#### 3.3.1 AngleModeStrategy 구현 (TDD)
- [ ] **RED**: DEG 모드 테스트
  ```javascript
  test('should calculate sin(30) as 0.5 in DEG mode', () => {
    calculator.setAngleMode('DEG');
    calculator.input('sin(30)');
    expect(calculator.calculate()).toBeCloseTo(0.5, 5);
  });
  ```
- [ ] **GREEN**: DegreeStrategy 구현
- [ ] **RED**: RAD 모드 테스트
- [ ] **GREEN**: RadianStrategy 구현
- [ ] **REFACTOR**: 전략 패턴 적용 (개방-폐쇄 원칙)
- [ ] **파일**: `src/js/domain/calculator/AngleModeStrategy.js`

### 3.4 과학 함수

#### 3.4.1 삼각함수 (TDD)
- [ ] **RED**: sin, cos, tan 테스트
- [ ] **GREEN**: 구현
- [ ] **REFACTOR**: 각도 모드 통합

#### 3.4.2 로그 함수 (TDD)
- [ ] **RED**: ln, log 테스트
- [ ] **GREEN**: 구현

#### 3.4.3 기타 함수 (TDD)
- [ ] **RED**: sqrt, power 테스트
- [ ] **GREEN**: 구현
- [ ] 상수 (π, e) 지원

**예상 소요 시간:** 3-4일

---

## Phase 4: 도메인 레이어 - 히스토리 관리 (TDD) (1-2일)

### 4.1 CalculationHistory 클래스

#### 4.1.1 기본 히스토리 관리 (TDD)
- [ ] **RED**: 히스토리 추가 테스트
  ```javascript
  describe('CalculationHistory', () => {
    test('should add calculation to history', () => {
      const history = new CalculationHistory();
      history.add('5 + 3', 8);
      expect(history.getAll()).toHaveLength(1);
    });
  });
  ```
- [ ] **GREEN**: 구현
- [ ] **파일**: `src/js/domain/history/CalculationHistory.js`

#### 4.1.2 히스토리 제한 (TDD)
- [ ] **RED**: 최대 50개 제한 테스트
  ```javascript
  test('should limit history to 50 items', () => {
    const history = new CalculationHistory(50);
    for (let i = 0; i < 60; i++) {
      history.add(`${i} + 1`, i + 1);
    }
    expect(history.getAll()).toHaveLength(50);
  });
  ```
- [ ] **GREEN**: 구현

#### 4.1.3 히스토리 조회 및 삭제 (TDD)
- [ ] **RED**: 전체 조회, 개별 조회, 삭제 테스트
- [ ] **GREEN**: 구현
- [ ] **REFACTOR**: 불변성 보장

### 4.2 히스토리 저장소 통합

#### 4.2.1 HistoryStorage 클래스 (TDD)
- [ ] **RED**: 저장/로드 테스트
- [ ] **GREEN**: LocalStorageAdapter 사용
- [ ] **REFACTOR**: 의존성 주입
- [ ] **파일**: `src/js/domain/history/HistoryStorage.js`

**예상 소요 시간:** 1-2일

---

## Phase 5: 애플리케이션 레이어 (TDD) (2일)

### 5.1 CalculatorController

#### 5.1.1 기본 컨트롤러 구현 (TDD)
- [ ] **RED**: 컨트롤러 테스트
  ```javascript
  describe('CalculatorController', () => {
    test('should handle number input', () => {});
    test('should handle operator input', () => {});
    test('should handle calculation', () => {});
    test('should handle clear', () => {});
  });
  ```
- [ ] **GREEN**: 구현
- [ ] **REFACTOR**: 의존성 주입, 단일 책임
- [ ] **파일**: `src/js/application/CalculatorController.js`

#### 5.1.2 오류 처리 통합
- [ ] **RED**: 오류 처리 테스트
- [ ] **GREEN**: 사용자 친화적 오류 메시지

### 5.2 HistoryController

#### 5.2.1 히스토리 컨트롤러 (TDD)
- [ ] **RED**: 히스토리 관리 테스트
- [ ] **GREEN**: 구현
- [ ] **파일**: `src/js/application/HistoryController.js`

**예상 소요 시간:** 2일

---

## Phase 6: UI 구현 (3-4일)

> **참고**: UI 컴포넌트는 자동화된 테스트를 작성하지 않습니다. 수동 테스트로 검증합니다.

### 6.1 HTML 마크업

#### 6.1.1 계산기 레이아웃
- [ ] 헤더 (메뉴, 모드 전환, 히스토리)
- [ ] 디스플레이 영역 (수식, 결과)
- [ ] 컨트롤 바 (DEG/RAD, 백스페이스)
- [ ] 키패드
  - [ ] 과학 함수 행 (2행 × 5열)
  - [ ] 구분선
  - [ ] 메인 그리드 (4열)

#### 6.1.2 접근성 (ARIA)
- [ ] 모든 버튼에 `aria-label` 추가
- [ ] 결과 디스플레이에 `role="status"` 추가
- [ ] 오류 메시지에 `role="alert"` 추가
- [ ] 키보드 탐색 순서 확인

### 6.2 CSS 스타일링

#### 6.2.1 Tailwind 커스텀 설정
- [ ] 색상 팔레트 정의
- [ ] 폰트 설정
- [ ] 반응형 브레이크포인트

#### 6.2.2 커스텀 스타일
- [ ] `src/css/custom.css` 작성
- [ ] 애니메이션 효과
- [ ] 호버/액티브 상태
- [ ] 그림자 및 그라디언트

### 6.3 DisplayManager

#### 6.3.1 디스플레이 관리 클래스
- [ ] **파일**: `src/js/presentation/DisplayManager.js`
- [ ] 수식 업데이트 메서드
- [ ] 결과 업데이트 메서드
- [ ] 숫자 포맷팅 (천 단위 구분)
- [ ] 오류 메시지 표시
- [ ] 애니메이션 효과

### 6.4 EventHandler

#### 6.4.1 이벤트 핸들러 구현
- [ ] **파일**: `src/js/presentation/EventHandler.js`
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

**예상 소요 시간:** 3-4일

---

## Phase 7: 메인 앱 통합 (1일)

### 7.1 main.js 구현

#### 7.1.1 앱 초기화
- [ ] **파일**: `src/js/main.js`
- [ ] 의존성 주입 설정
  ```javascript
  const storage = new LocalStorageAdapter();
  const evaluator = new MathJsAdapter();
  const calculator = new Calculator(evaluator);
  const history = new CalculationHistory();
  const calculatorController = new CalculatorController(calculator, history);
  const displayManager = new DisplayManager(/* DOM elements */);
  ```
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

**예상 소요 시간:** 1일

---

## Phase 8: 단위 변환 기능 (선택사항) (2-3일)

### 8.1 UnitConverter 클래스 (TDD)

#### 8.1.1 기본 변환 로직
- [ ] **RED**: 길이 변환 테스트
  ```javascript
  describe('UnitConverter', () => {
    test('should convert meters to feet', () => {
      const converter = new UnitConverter();
      expect(converter.convert(1, 'm', 'ft', 'length')).toBeCloseTo(3.28084, 5);
    });
  });
  ```
- [ ] **GREEN**: 구현
- [ ] **파일**: `src/js/domain/unit-converter/UnitConverter.js`

#### 8.1.2 다양한 카테고리 지원
- [ ] 길이 (m, km, ft, in, mi)
- [ ] 무게 (kg, g, lb, oz)
- [ ] 온도 (°C, °F, K)
- [ ] 부피 (L, mL, gal, cup)
- [ ] 면적 (m², ft², acre)
- [ ] 속도 (km/h, mph, m/s)

#### 8.1.3 ConversionStrategy 패턴 (TDD)
- [ ] **RED**: 전략 패턴 테스트
- [ ] **GREEN**: 구현
- [ ] **REFACTOR**: 개방-폐쇄 원칙 적용
- [ ] **파일**: `src/js/domain/unit-converter/ConversionStrategy.js`

### 8.2 UI 통합
- [ ] 단위 변환 모드 UI
- [ ] CALC/UNIT 모드 전환

**예상 소요 시간:** 2-3일

---

## Phase 9: 테스트 및 품질 보증 (2-3일)

### 9.1 테스트 커버리지 확인
- [ ] 커버리지 리포트 생성
  ```bash
  npm run test:coverage
  ```
- [ ] 80% 이상 커버리지 확인
- [ ] 누락된 테스트 추가

### 9.2 린팅 및 코드 품질
- [ ] ESLint 실행
  ```bash
  npm run lint
  ```
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

**예상 소요 시간:** 2-3일

---

## Phase 10: 배포 및 문서화 (1-2일)

### 10.1 GitHub 저장소 설정
- [ ] README.md 업데이트
  - [ ] `YOUR_USERNAME` 실제 사용자명으로 변경
  - [ ] 스크린샷 추가
  - [ ] 데모 링크 업데이트
- [ ] LICENSE 파일 추가
- [ ] CONTRIBUTING.md 작성 (선택사항)

### 10.2 GitHub Pages 배포
- [ ] GitHub 저장소 생성
- [ ] 코드 푸시
  ```bash
  git add .
  git commit -m "feat: initial release"
  git push -u origin main
  ```
- [ ] GitHub Pages 설정
  - Settings → Pages → Source: GitHub Actions
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

**예상 소요 시간:** 1-2일

---

## Phase 11: 향후 개선사항 (백로그)

### 11.1 고급 기능
- [ ] 그래프 계산기 (함수 플로팅)
- [ ] 행렬 연산
- [ ] 복소수 지원
- [ ] 프로그래밍 가능한 함수
- [ ] 방정식 풀이

### 11.2 협업 기능
- [ ] 계산 공유 (링크 생성)
- [ ] 히스토리 내보내기 (CSV/PDF)
- [ ] 클라우드 동기화

### 11.3 교육 기능
- [ ] 단계별 풀이 표시
- [ ] 공식 참조 라이브러리
- [ ] 연습 문제

### 11.4 PWA 기능
- [ ] Service Worker 구현
- [ ] 오프라인 지원
- [ ] 앱 설치 지원
- [ ] 푸시 알림 (선택사항)

### 11.5 테마 및 커스터마이징
- [ ] 라이트 모드 지원
- [ ] 커스텀 테마
- [ ] 레이아웃 옵션
- [ ] 버튼 커스터마이징

---

## 📊 전체 일정 요약

| Phase | 작업 내용 | 예상 소요 시간 | TDD 적용 |
|-------|----------|--------------|---------|
| Phase 1 | 프로젝트 초기 설정 | 1-2일 | - |
| Phase 2 | 인프라 레이어 | 2-3일 | ✅ |
| Phase 3 | 계산기 핵심 로직 | 3-4일 | ✅ |
| Phase 4 | 히스토리 관리 | 1-2일 | ✅ |
| Phase 5 | 애플리케이션 레이어 | 2일 | ✅ |
| Phase 6 | UI 구현 | 3-4일 | ❌ (수동 테스트) |
| Phase 7 | 메인 앱 통합 | 1일 | ❌ (수동 테스트) |
| Phase 8 | 단위 변환 (선택) | 2-3일 | ✅ |
| Phase 9 | 테스트 및 QA | 2-3일 | - |
| Phase 10 | 배포 및 문서화 | 1-2일 | - |

**총 예상 소요 시간**: 16-24일 (약 3-4주)

**테스트 전략**:
- ✅ **코어 로직 (Phase 2-5, 8)**: TDD 적용 - 자동화된 단위 테스트
- ❌ **UI (Phase 6-7)**: 수동 테스트만 수행 - 자동화된 UI 테스트 없음

---

## 📝 개발 체크리스트

### 매일 확인사항
- [ ] 모든 테스트 통과 (`npm test`)
- [ ] 린팅 통과 (`npm run lint`)
- [ ] 커버리지 80% 이상 유지
- [ ] Git 커밋 (의미 있는 단위로)

### 매주 확인사항
- [ ] 코드 리뷰 (SOLID 원칙 준수)
- [ ] 문서 업데이트
- [ ] 진행 상황 점검

### Phase 완료 시 확인사항
- [ ] 모든 테스트 통과
- [ ] 코드 리뷰 완료
- [ ] 문서 업데이트
- [ ] Git 태그 생성 (선택사항)

---

## 🎯 우선순위

### 높음 (MVP 필수)
1. Phase 1-7: 기본 계산기 기능
2. Phase 9: 테스트 및 QA
3. Phase 10: 배포

### 중간 (v1.1)
1. Phase 8: 단위 변환
2. 히스토리 패널 UI 개선
3. 키보드 단축키 완성도 향상

### 낮음 (v2.0+)
1. Phase 11: 향후 개선사항
2. PWA 기능
3. 고급 수학 기능

---

## 📚 참고 문서

- [PRD.md](PRD.md) - 제품 요구사항
- [TECH_SPEC.md](TECH_SPEC.md) - 기술 명세
- [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) - 개발 가이드
- [.agent/rules/tdd.md](../.agent/rules/tdd.md) - TDD 규칙
- [.agent/rules/solid.md](../.agent/rules/solid.md) - SOLID 원칙

---

**문서 버전**: 1.0  
**최종 업데이트**: 2025-12-23  
**다음 검토**: Phase 1 완료 후
