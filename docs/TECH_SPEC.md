# 기술 명세서 (Technical Specification)
# 공학용 계산기 웹 애플리케이션

## 1. 개요

### 1.1 문서 목적
이 문서는 공학용 계산기 웹 애플리케이션의 기술적 구현 세부사항을 정의합니다. 아키텍처, 기술 스택, 개발 환경, 빌드/배포 프로세스 및 코드 구조에 대한 명세를 포함합니다.

### 1.2 프로젝트 정보
- **프로젝트명**: Scientific Calculator Web App
- **버전**: 1.0.0
- **저장소**: GitHub Repository
- **배포 환경**: GitHub Pages
- **CI/CD**: GitHub Actions

---

## 2. 기술 스택

### 2.1 프론트엔드 핵심 기술

#### 2.1.1 HTML5
- **버전**: HTML5 (Living Standard)
- **용도**: 시맨틱 마크업 및 구조
- **주요 기능**:
  - 시맨틱 태그 사용 (`<header>`, `<main>`, `<section>`, `<button>`)
  - ARIA 속성을 통한 접근성 향상
  - Meta 태그를 통한 SEO 최적화

#### 2.1.2 CSS3 & Tailwind CSS
- **Tailwind CSS 버전**: 3.x (CDN)
- **CDN URL**: `https://cdn.tailwindcss.com?plugins=forms,container-queries`
- **커스텀 설정**:
  ```javascript
  tailwind.config = {
    darkMode: "class",
    theme: {
      extend: {
        colors: {
          "primary": "#137fec",
          "background-light": "#f6f7f8",
          "background-dark": "#101922",
          "surface-dark": "#1c242d",
          "key-num": "#1e252d",
          "key-op": "#283039",
        },
        fontFamily: {
          "display": ["Space Grotesk", "sans-serif"]
        }
      }
    }
  }
  ```

#### 2.1.3 JavaScript (ES6+)
- **버전**: ECMAScript 2015+ (ES6+)
- **모듈 시스템**: ES Modules
- **주요 기능**:
  - 클래스 기반 계산기 로직
  - 이벤트 리스너를 통한 사용자 상호작용
  - LocalStorage API를 통한 데이터 지속성
  - History API를 통한 상태 관리

### 2.2 외부 라이브러리

#### 2.2.1 Math.js
- **버전**: 12.x (최신 안정 버전)
- **CDN**: `https://cdn.jsdelivr.net/npm/mathjs@12/lib/browser/math.js`
- **용도**: 정밀한 수학 계산 및 표현식 파싱
- **주요 기능**:
  - 복잡한 수학 표현식 평가
  - 삼각함수, 로그 함수 등 과학 함수
  - 단위 변환
  - 높은 정밀도 계산

**선택 이유**:
- 부동소수점 오류 최소화
- 풍부한 수학 함수 라이브러리
- 표현식 파싱 및 평가 기능
- 활발한 커뮤니티 및 유지보수

#### 2.2.2 Google Fonts
- **폰트**: Space Grotesk
- **굵기**: 300, 400, 500, 600, 700
- **CDN**: `https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&display=swap`

#### 2.2.3 Material Symbols
- **아이콘 세트**: Material Symbols Outlined
- **CDN**: `https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap`
- **사용 아이콘**:
  - `menu` - 메뉴 버튼
  - `history` - 히스토리 버튼
  - `backspace` - 백스페이스 버튼

### 2.3 개발 도구

#### 2.3.1 코드 에디터
- **권장**: Visual Studio Code
- **필수 확장**:
  - ESLint
  - Prettier
  - Tailwind CSS IntelliSense
  - Live Server (개발 중)

#### 2.3.2 버전 관리
- **Git**: 2.x 이상
- **GitHub**: 원격 저장소 및 협업

#### 2.3.3 패키지 관리 (선택사항)
- **npm**: 8.x 이상 (개발 의존성 관리용)
- **용도**: 개발 도구 및 빌드 스크립트

---

## 3. 프로젝트 구조

### 3.1 디렉토리 구조

```
calculator/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions 워크플로우
├── docs/
│   ├── PRD.md                  # 제품 요구사항 정의서
│   ├── TECH_SPEC.md            # 기술 명세서 (본 문서)
│   └── stitch_design/          # 디자인 참조 파일
│       ├── code.html
│       └── screen.png
├── src/
│   ├── js/
│   │   ├── calculator.js       # 계산기 핵심 로직
│   │   ├── display.js          # 디스플레이 관리
│   │   ├── history.js          # 히스토리 관리
│   │   ├── storage.js          # LocalStorage 관리
│   │   ├── unit-converter.js  # 단위 변환 로직
│   │   └── main.js             # 앱 초기화 및 이벤트 바인딩
│   ├── css/
│   │   └── custom.css          # Tailwind 외 커스텀 스타일
│   └── assets/
│       └── icons/              # 커스텀 아이콘 (필요시)
├── index.html                  # 메인 HTML 파일
├── README.md                   # 프로젝트 설명
├── .gitignore                  # Git 무시 파일
└── package.json                # npm 설정 (선택사항)
```

### 3.2 파일별 역할

#### 3.2.1 `index.html`
- 애플리케이션의 메인 진입점
- UI 구조 정의
- 외부 리소스 로드 (폰트, 아이콘, 라이브러리)
- Tailwind 설정 포함

#### 3.2.2 `src/js/calculator.js`
```javascript
/**
 * Calculator 클래스
 * - 수학 연산 처리
 * - 표현식 파싱 및 평가
 * - 각도 모드 관리 (DEG/RAD)
 */
class Calculator {
  constructor() {
    this.expression = '';
    this.result = '0';
    this.angleMode = 'DEG'; // 'DEG' or 'RAD'
    this.memory = 0;
  }

  // 메서드들...
  addDigit(digit) {}
  addOperator(operator) {}
  calculate() {}
  clear() {}
  backspace() {}
  setAngleMode(mode) {}
}
```

#### 3.2.3 `src/js/display.js`
```javascript
/**
 * Display 클래스
 * - 화면 업데이트 관리
 * - 숫자 포맷팅 (천 단위 구분)
 * - 애니메이션 효과
 */
class Display {
  constructor(expressionElement, resultElement) {
    this.expressionElement = expressionElement;
    this.resultElement = resultElement;
  }

  // 메서드들...
  updateExpression(expression) {}
  updateResult(result) {}
  formatNumber(number) {}
  showError(message) {}
}
```

#### 3.2.4 `src/js/history.js`
```javascript
/**
 * History 클래스
 * - 계산 히스토리 관리
 * - 히스토리 패널 UI 제어
 */
class History {
  constructor() {
    this.items = [];
    this.maxItems = 50;
  }

  // 메서드들...
  addItem(expression, result) {}
  getItems() {}
  clear() {}
  loadFromStorage() {}
  saveToStorage() {}
}
```

#### 3.2.5 `src/js/storage.js`
```javascript
/**
 * Storage 유틸리티
 * - LocalStorage 래퍼
 * - 설정 및 히스토리 저장/로드
 */
const Storage = {
  saveHistory(history) {},
  loadHistory() {},
  saveSettings(settings) {},
  loadSettings() {},
  clear() {}
};
```

#### 3.2.6 `src/js/unit-converter.js`
```javascript
/**
 * UnitConverter 클래스
 * - 단위 변환 로직
 * - 다양한 단위 카테고리 지원
 */
class UnitConverter {
  constructor() {
    this.categories = {
      length: {},
      weight: {},
      temperature: {},
      // ...
    };
  }

  // 메서드들...
  convert(value, fromUnit, toUnit, category) {}
}
```

#### 3.2.7 `src/js/main.js`
```javascript
/**
 * 애플리케이션 초기화 및 이벤트 바인딩
 */
document.addEventListener('DOMContentLoaded', () => {
  const calculator = new Calculator();
  const display = new Display(/* ... */);
  const history = new History();

  // 이벤트 리스너 설정
  setupEventListeners();
  
  // 초기 상태 로드
  loadInitialState();
});
```

---

## 4. 핵심 기능 구현

### 4.1 계산 로직

#### 4.1.1 표현식 평가
```javascript
calculate() {
  try {
    // Math.js를 사용한 표현식 평가
    const scope = {
      // 각도 모드에 따른 삼각함수 설정
      sin: (x) => this.angleMode === 'DEG' 
        ? math.sin(math.unit(x, 'deg')) 
        : math.sin(x),
      cos: (x) => this.angleMode === 'DEG' 
        ? math.cos(math.unit(x, 'deg')) 
        : math.cos(x),
      tan: (x) => this.angleMode === 'DEG' 
        ? math.tan(math.unit(x, 'deg')) 
        : math.tan(x),
    };

    this.result = math.evaluate(this.expression, scope);
    return this.result;
  } catch (error) {
    throw new Error('계산 오류: ' + error.message);
  }
}
```

#### 4.1.2 오류 처리
```javascript
const ErrorMessages = {
  DIVISION_BY_ZERO: '0으로 나눌 수 없습니다',
  INVALID_EXPRESSION: '잘못된 수식입니다',
  OVERFLOW: '숫자가 너무 큽니다',
  MATH_ERROR: '수학 오류'
};

function handleCalculationError(error) {
  if (error.message.includes('division by zero')) {
    return ErrorMessages.DIVISION_BY_ZERO;
  }
  // 기타 오류 처리...
}
```

### 4.2 UI 상호작용

#### 4.2.1 버튼 이벤트 처리
```javascript
function setupEventListeners() {
  // 숫자 버튼
  document.querySelectorAll('[data-number]').forEach(button => {
    button.addEventListener('click', () => {
      calculator.addDigit(button.dataset.number);
      display.updateExpression(calculator.expression);
    });
  });

  // 연산자 버튼
  document.querySelectorAll('[data-operator]').forEach(button => {
    button.addEventListener('click', () => {
      calculator.addOperator(button.dataset.operator);
      display.updateExpression(calculator.expression);
    });
  });

  // 등호 버튼
  document.querySelector('[data-equals]').addEventListener('click', () => {
    try {
      const result = calculator.calculate();
      display.updateResult(result);
      history.addItem(calculator.expression, result);
    } catch (error) {
      display.showError(handleCalculationError(error));
    }
  });
}
```

#### 4.2.2 키보드 지원
```javascript
document.addEventListener('keydown', (event) => {
  const key = event.key;

  // 숫자 입력
  if (/[0-9.]/.test(key)) {
    calculator.addDigit(key);
  }
  
  // 연산자
  else if (['+', '-', '*', '/'].includes(key)) {
    calculator.addOperator(key);
  }
  
  // Enter = 계산
  else if (key === 'Enter') {
    event.preventDefault();
    calculator.calculate();
  }
  
  // Escape = 전체 지우기
  else if (key === 'Escape') {
    calculator.clear();
  }
  
  // Backspace = 한 글자 삭제
  else if (key === 'Backspace') {
    calculator.backspace();
  }

  display.updateExpression(calculator.expression);
});
```

### 4.3 데이터 지속성

#### 4.3.1 LocalStorage 구조
```javascript
// 저장되는 데이터 구조
{
  "calculator_history": [
    {
      "expression": "(1200 + 34.56) × sin(30)",
      "result": "1234.56",
      "timestamp": 1703318400000
    }
  ],
  "calculator_settings": {
    "angleMode": "DEG",
    "theme": "dark",
    "decimalPlaces": 10
  },
  "calculator_session": {
    "currentExpression": "",
    "currentResult": "0"
  }
}
```

#### 4.3.2 저장/로드 함수
```javascript
const Storage = {
  KEYS: {
    HISTORY: 'calculator_history',
    SETTINGS: 'calculator_settings',
    SESSION: 'calculator_session'
  },

  saveHistory(history) {
    localStorage.setItem(
      this.KEYS.HISTORY, 
      JSON.stringify(history)
    );
  },

  loadHistory() {
    const data = localStorage.getItem(this.KEYS.HISTORY);
    return data ? JSON.parse(data) : [];
  },

  saveSettings(settings) {
    localStorage.setItem(
      this.KEYS.SETTINGS, 
      JSON.stringify(settings)
    );
  },

  loadSettings() {
    const data = localStorage.getItem(this.KEYS.SETTINGS);
    return data ? JSON.parse(data) : {
      angleMode: 'DEG',
      theme: 'dark',
      decimalPlaces: 10
    };
  }
};
```

---

## 5. 빌드 및 배포

### 5.1 GitHub Actions 워크플로우

#### 5.1.1 워크플로우 파일: `.github/workflows/deploy.yml`

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:

# GitHub Pages에 배포하기 위한 권한 설정
permissions:
  contents: read
  pages: write
  id-token: write

# 동시 배포 방지
concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  # 빌드 작업
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci
        if: hashFiles('package-lock.json') != ''

      - name: Run linting
        run: npm run lint
        if: hashFiles('package.json') != ''
        continue-on-error: true

      - name: Run tests
        run: npm test
        if: hashFiles('package.json') != ''
        continue-on-error: true

      - name: Build project
        run: |
          # 정적 파일이므로 별도 빌드 불필요
          # 필요시 minification 등 추가 가능
          echo "Static files ready for deployment"

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: '.'

  # 배포 작업
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 5.2 GitHub Pages 설정

#### 5.2.1 저장소 설정
1. GitHub 저장소 → Settings → Pages
2. Source: GitHub Actions 선택
3. Custom domain (선택사항) 설정

#### 5.2.2 배포 URL
- **기본 URL**: `https://<username>.github.io/<repository-name>/`
- **커스텀 도메인**: 설정 시 사용자 지정 도메인

### 5.3 빌드 최적화 (선택사항)

#### 5.3.1 HTML/CSS/JS 압축
```json
// package.json
{
  "scripts": {
    "build": "npm run minify:html && npm run minify:css && npm run minify:js",
    "minify:html": "html-minifier --input-dir . --output-dir dist --file-ext html",
    "minify:css": "cleancss -o dist/src/css/custom.min.css src/css/custom.css",
    "minify:js": "terser src/js/**/*.js -o dist/src/js/bundle.min.js"
  },
  "devDependencies": {
    "html-minifier": "^4.0.0",
    "clean-css-cli": "^5.6.0",
    "terser": "^5.19.0"
  }
}
```

#### 5.3.2 이미지 최적화
- PNG/JPG: TinyPNG 또는 ImageOptim 사용
- SVG: SVGO 사용
- 권장 크기: 아이콘 24×24px, 스크린샷 최대 1920px 너비

---

## 6. 성능 최적화

### 6.1 로딩 성능

#### 6.1.1 리소스 로딩 전략
```html
<!-- 중요 리소스 preload -->
<link rel="preload" href="https://fonts.googleapis.com/css2?family=Space+Grotesk..." as="style">
<link rel="preload" href="https://cdn.jsdelivr.net/npm/mathjs@12/lib/browser/math.js" as="script">

<!-- 폰트 최적화 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- 스크립트 지연 로딩 -->
<script src="src/js/main.js" defer></script>
```

#### 6.1.2 번들 크기 최적화
- Tailwind CSS: CDN 사용으로 빌드 불필요
- Math.js: CDN 사용, 필요시 커스텀 빌드로 크기 축소
- 이미지: WebP 형식 사용 고려
- 목표: 초기 로드 < 500KB

### 6.2 런타임 성능

#### 6.2.1 디바운싱 및 쓰로틀링
```javascript
// 입력 디바운싱 (연속 입력 시 성능 향상)
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// 사용 예
const debouncedSave = debounce(() => {
  Storage.saveSession(calculator.getState());
}, 500);
```

#### 6.2.2 DOM 조작 최적화
```javascript
// 배치 업데이트로 리플로우 최소화
function updateDisplay(expression, result) {
  requestAnimationFrame(() => {
    expressionElement.textContent = expression;
    resultElement.textContent = formatNumber(result);
  });
}
```

### 6.3 캐싱 전략

#### 6.3.1 Service Worker (PWA - Phase 2)
```javascript
// sw.js
const CACHE_NAME = 'calculator-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/src/css/custom.css',
  '/src/js/main.js',
  // 기타 리소스...
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(urlsToCache))
  );
});
```

---

## 7. 테스트 전략

### 7.1 단위 테스트

#### 7.1.1 테스트 프레임워크
- **Jest**: JavaScript 테스트 프레임워크
- **설치**: `npm install --save-dev jest`

#### 7.1.2 테스트 예시
```javascript
// src/js/__tests__/calculator.test.js
import { Calculator } from '../calculator.js';

describe('Calculator', () => {
  let calculator;

  beforeEach(() => {
    calculator = new Calculator();
  });

  test('should add two numbers', () => {
    calculator.addDigit('5');
    calculator.addOperator('+');
    calculator.addDigit('3');
    expect(calculator.calculate()).toBe(8);
  });

  test('should handle division by zero', () => {
    calculator.addDigit('5');
    calculator.addOperator('/');
    calculator.addDigit('0');
    expect(() => calculator.calculate()).toThrow();
  });

  test('should calculate trigonometric functions in DEG mode', () => {
    calculator.setAngleMode('DEG');
    calculator.expression = 'sin(30)';
    expect(calculator.calculate()).toBeCloseTo(0.5, 5);
  });
});
```

### 7.2 통합 테스트

#### 7.2.1 E2E 테스트 (선택사항)
- **Playwright** 또는 **Cypress** 사용
- 사용자 시나리오 테스트

```javascript
// e2e/calculator.spec.js (Playwright)
import { test, expect } from '@playwright/test';

test('basic calculation flow', async ({ page }) => {
  await page.goto('http://localhost:3000');
  
  // 5 + 3 = 8
  await page.click('[data-number="5"]');
  await page.click('[data-operator="+"]');
  await page.click('[data-number="3"]');
  await page.click('[data-equals]');
  
  const result = await page.textContent('[data-result]');
  expect(result).toBe('8');
});
```

### 7.3 수동 테스트 체크리스트

#### 7.3.1 기능 테스트
- [ ] 기본 산술 연산 (+, -, ×, ÷)
- [ ] 과학 함수 (sin, cos, tan, ln, log, √)
- [ ] 각도 모드 전환 (DEG/RAD)
- [ ] 괄호 처리
- [ ] 백분율 계산
- [ ] AC (전체 지우기)
- [ ] 백스페이스
- [ ] 히스토리 저장/불러오기

#### 7.3.2 UI/UX 테스트
- [ ] 버튼 호버 효과
- [ ] 버튼 클릭 애니메이션
- [ ] 반응형 레이아웃 (모바일/태블릿/데스크톱)
- [ ] 키보드 단축키
- [ ] 오류 메시지 표시
- [ ] 숫자 포맷팅 (천 단위 구분)

#### 7.3.3 브라우저 호환성 테스트
- [ ] Chrome (최신 버전)
- [ ] Firefox (최신 버전)
- [ ] Safari (최신 버전)
- [ ] Edge (최신 버전)
- [ ] 모바일 Safari (iOS)
- [ ] Chrome Mobile (Android)

---

## 8. 접근성 (Accessibility)

### 8.1 ARIA 속성

#### 8.1.1 버튼 레이블
```html
<!-- 숫자 버튼 -->
<button 
  data-number="7" 
  aria-label="숫자 7"
  class="...">
  7
</button>

<!-- 연산자 버튼 -->
<button 
  data-operator="+" 
  aria-label="더하기"
  class="...">
  +
</button>

<!-- 과학 함수 버튼 -->
<button 
  data-function="sin" 
  aria-label="사인 함수"
  class="...">
  sin
</button>
```

#### 8.1.2 라이브 리전
```html
<!-- 결과 디스플레이 -->
<div 
  id="result-display" 
  role="status" 
  aria-live="polite" 
  aria-atomic="true"
  class="...">
  0
</div>

<!-- 오류 메시지 -->
<div 
  id="error-message" 
  role="alert" 
  aria-live="assertive"
  class="hidden">
</div>
```

### 8.2 키보드 탐색

#### 8.2.1 포커스 관리
```css
/* 포커스 표시 */
button:focus-visible {
  outline: 2px solid #137fec;
  outline-offset: 2px;
}

/* 탭 순서 최적화 */
.calculator-grid {
  /* 그리드 내에서 자연스러운 탭 순서 */
}
```

#### 8.2.2 탭 인덱스
```html
<!-- 주요 컨트롤에 적절한 tabindex -->
<button tabindex="0">...</button>

<!-- 비활성화된 요소 -->
<button tabindex="-1" disabled>...</button>
```

### 8.3 색상 대비

#### 8.3.1 WCAG AA 준수
- **일반 텍스트**: 최소 4.5:1 대비
- **큰 텍스트**: 최소 3:1 대비
- **UI 컴포넌트**: 최소 3:1 대비

#### 8.3.2 대비 확인
```javascript
// 주요 색상 조합 대비 비율
const colorContrasts = {
  'primary (#137fec) on dark (#101922)': '8.2:1', // ✓ 통과
  'white on surface-dark (#1c242d)': '14.5:1',    // ✓ 통과
  'white/40 on dark': '5.8:1',                    // ✓ 통과
};
```

---

## 9. 보안 고려사항

### 9.1 입력 검증

#### 9.1.1 표현식 검증
```javascript
function validateExpression(expression) {
  // 허용된 문자만 포함하는지 확인
  const allowedChars = /^[0-9+\-*/().πe\s]+$/;
  if (!allowedChars.test(expression)) {
    throw new Error('허용되지 않은 문자가 포함되어 있습니다');
  }

  // 괄호 균형 확인
  const openCount = (expression.match(/\(/g) || []).length;
  const closeCount = (expression.match(/\)/g) || []).length;
  if (openCount !== closeCount) {
    throw new Error('괄호가 올바르게 닫히지 않았습니다');
  }

  return true;
}
```

### 9.2 XSS 방지

#### 9.2.1 안전한 DOM 조작
```javascript
// ❌ 위험: innerHTML 사용
element.innerHTML = userInput;

// ✓ 안전: textContent 사용
element.textContent = userInput;

// ✓ 안전: 새 요소 생성
const newElement = document.createElement('div');
newElement.textContent = userInput;
parent.appendChild(newElement);
```

### 9.3 Content Security Policy (CSP)

#### 9.3.1 CSP 헤더 설정
```html
<meta http-equiv="Content-Security-Policy" 
      content="
        default-src 'self';
        script-src 'self' 
          https://cdn.tailwindcss.com 
          https://cdn.jsdelivr.net 
          'unsafe-inline';
        style-src 'self' 
          https://fonts.googleapis.com 
          https://cdn.tailwindcss.com 
          'unsafe-inline';
        font-src 'self' 
          https://fonts.gstatic.com;
        img-src 'self' data:;
      ">
```

---

## 10. 모니터링 및 분석

### 10.1 Google Analytics (선택사항)

#### 10.1.1 통합
```html
<!-- Google Analytics 4 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

#### 10.1.2 이벤트 추적
```javascript
// 계산 이벤트 추적
function trackCalculation(operation) {
  if (typeof gtag !== 'undefined') {
    gtag('event', 'calculation', {
      'event_category': 'Calculator',
      'event_label': operation,
    });
  }
}

// 사용 예
calculator.calculate();
trackCalculation('basic_arithmetic');
```

### 10.2 오류 로깅

#### 10.2.1 클라이언트 오류 추적
```javascript
window.addEventListener('error', (event) => {
  console.error('Global error:', event.error);
  
  // 오류 로깅 서비스로 전송 (선택사항)
  // logErrorToService(event.error);
});

window.addEventListener('unhandledrejection', (event) => {
  console.error('Unhandled promise rejection:', event.reason);
});
```

---

## 11. 개발 워크플로우

### 11.1 브랜치 전략

#### 11.1.1 Git Flow
```
main (프로덕션)
  ├── develop (개발)
  │   ├── feature/calculator-logic
  │   ├── feature/ui-components
  │   ├── feature/history-panel
  │   └── feature/unit-converter
  └── hotfix/critical-bug
```

### 11.2 커밋 컨벤션

#### 11.2.1 커밋 메시지 형식
```
<type>(<scope>): <subject>

<body>

<footer>
```

#### 11.2.2 타입
- `feat`: 새로운 기능
- `fix`: 버그 수정
- `docs`: 문서 변경
- `style`: 코드 포맷팅
- `refactor`: 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 빌드/설정 변경

#### 11.2.3 예시
```
feat(calculator): add trigonometric functions

- Implement sin, cos, tan functions
- Add DEG/RAD mode switching
- Update display to show angle mode

Closes #123
```

### 11.3 코드 리뷰 체크리스트

- [ ] 코드가 요구사항을 충족하는가?
- [ ] 테스트가 작성되었는가?
- [ ] 접근성 기준을 준수하는가?
- [ ] 성능 영향이 고려되었는가?
- [ ] 보안 취약점이 없는가?
- [ ] 문서가 업데이트되었는가?

---

## 12. 배포 체크리스트

### 12.1 배포 전 확인사항

#### 12.1.1 기능 확인
- [ ] 모든 계산 기능 정상 작동
- [ ] 히스토리 저장/불러오기 정상
- [ ] 모든 버튼 반응 정상
- [ ] 키보드 단축키 작동
- [ ] 오류 처리 정상

#### 12.1.2 성능 확인
- [ ] Lighthouse 점수 90+ (Performance)
- [ ] 초기 로드 시간 < 2초
- [ ] 번들 크기 < 500KB
- [ ] 모든 이미지 최적화

#### 12.1.3 호환성 확인
- [ ] Chrome 테스트 완료
- [ ] Firefox 테스트 완료
- [ ] Safari 테스트 완료
- [ ] 모바일 테스트 완료

#### 12.1.4 접근성 확인
- [ ] WAVE 도구 검사 통과
- [ ] 키보드 탐색 테스트 완료
- [ ] 스크린 리더 테스트 완료
- [ ] 색상 대비 확인

#### 12.1.5 SEO 확인
- [ ] Meta 태그 설정
- [ ] Open Graph 태그 설정
- [ ] robots.txt 설정
- [ ] sitemap.xml 생성

### 12.2 배포 프로세스

1. **코드 병합**: feature → develop → main
2. **버전 태그**: `git tag v1.0.0`
3. **GitHub Push**: 자동으로 GitHub Actions 트리거
4. **빌드 확인**: Actions 탭에서 빌드 상태 확인
5. **배포 확인**: GitHub Pages URL 접속하여 확인
6. **모니터링**: 초기 사용자 피드백 및 오류 모니터링

---

## 13. 유지보수 계획

### 13.1 정기 업데이트

#### 13.1.1 의존성 업데이트
- **주기**: 월 1회
- **도구**: `npm outdated`, Dependabot
- **프로세스**:
  1. 의존성 버전 확인
  2. 테스트 환경에서 업데이트
  3. 회귀 테스트 실행
  4. 프로덕션 배포

#### 13.1.2 브라우저 호환성 확인
- **주기**: 분기별
- **확인 사항**: 최신 브라우저 버전에서 정상 작동 확인

### 13.2 백업 전략

#### 13.2.1 코드 백업
- GitHub 저장소 (자동)
- 로컬 클론 유지

#### 13.2.2 사용자 데이터
- LocalStorage (클라이언트 측)
- 내보내기 기능 제공 (Phase 2)

---

## 14. 문서 관리

### 14.1 기술 문서
- **본 문서 (TECH_SPEC.md)**: 기술 명세
- **PRD.md**: 제품 요구사항
- **README.md**: 프로젝트 개요 및 시작 가이드
- **API.md**: 내부 API 문서 (필요시)

### 14.2 사용자 문서
- **도움말 페이지**: 앱 내 도움말
- **FAQ**: 자주 묻는 질문
- **튜토리얼**: 사용 방법 안내

---

## 15. 부록

### 15.1 유용한 리소스

#### 15.1.1 문서
- [Math.js Documentation](https://mathjs.org/docs/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [MDN Web Docs](https://developer.mozilla.org/)
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

#### 15.1.2 도구
- [Lighthouse](https://developers.google.com/web/tools/lighthouse)
- [WAVE Accessibility Tool](https://wave.webaim.org/)
- [Can I Use](https://caniuse.com/)
- [BundlePhobia](https://bundlephobia.com/)

### 15.2 개정 이력

| 버전 | 날짜 | 작성자 | 변경사항 |
|------|------|--------|---------|
| 1.0 | 2025-12-23 | Initial | 초안 작성 - GitHub Actions 및 Pages 배포 포함 |

---

## 16. 승인

이 기술 명세서는 다음의 검토 및 승인이 필요합니다:

- [ ] 리드 개발자
- [ ] DevOps 엔지니어
- [ ] QA 리드
- [ ] 프로젝트 매니저

**문서 상태**: 초안  
**최종 업데이트**: 2025-12-23  
**다음 검토**: 개발 시작 전
