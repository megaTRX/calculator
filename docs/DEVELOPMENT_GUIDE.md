# 개발 가이드 (Development Guide)
# 공학용 계산기 웹 애플리케이션

## 📋 목차
1. [개발 원칙](#1-개발-원칙)
2. [TDD (Test-Driven Development)](#2-tdd-test-driven-development)
3. [SOLID 원칙](#3-solid-원칙)
4. [프로젝트 아키텍처](#4-프로젝트-아키텍처)
5. [코딩 컨벤션](#5-코딩-컨벤션)
6. [테스트 가이드](#6-테스트-가이드)

---

## 1. 개발 원칙

### 1.1 핵심 규칙

> [!IMPORTANT]
> 이 프로젝트는 다음 두 가지 핵심 원칙을 **반드시** 준수해야 합니다:

1. **TDD (Test-Driven Development)**
   - UI를 제외한 모든 코어 로직은 TDD로 구현
   - Red → Green → Refactor 사이클 엄격히 준수
   - 테스트 없는 코드는 병합 불가

2. **SOLID 원칙**
   - 모든 클래스와 모듈은 SOLID 원칙을 따라 설계
   - 코드 리뷰 시 SOLID 준수 여부 필수 확인
   - 리팩토링 시 SOLID 원칙 개선 우선

### 1.2 적용 범위

#### TDD 적용 대상 (필수 - 자동화된 단위 테스트)
- ✅ 계산 로직 (`calculator.js`)
- ✅ 수식 파싱 및 평가
- ✅ 히스토리 관리 (`history.js`)
- ✅ 스토리지 관리 (`storage.js`)
- ✅ 단위 변환 로직 (`unit-converter.js`)
- ✅ 애플리케이션 컨트롤러
- ✅ 유틸리티 함수

#### TDD 적용 제외 (수동 테스트만)
- ❌ UI 이벤트 핸들러 - 수동으로 검증
- ❌ DOM 조작 로직 - 수동으로 검증
- ❌ 애니메이션 효과 - 수동으로 검증
- ❌ 프레젠테이션 레이어 전체 - 수동으로 검증

> [!NOTE]
> UI 컴포넌트는 자동화된 테스트를 작성하지 않습니다. 브라우저에서 직접 수동으로 테스트합니다.

---

## 2. TDD (Test-Driven Development)

### 2.1 TDD 사이클

```
┌─────────────────────────────────────────┐
│  1. RED: 실패하는 테스트 작성           │
│     - 구현하려는 기능의 테스트 먼저 작성│
│     - 테스트 실행 → 실패 확인           │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  2. GREEN: 테스트를 통과하는 최소 코드  │
│     - 테스트를 통과할 수 있는 코드 작성 │
│     - 테스트 실행 → 성공 확인           │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  3. REFACTOR: 코드 개선                 │
│     - 중복 제거, 가독성 향상            │
│     - SOLID 원칙 적용                   │
│     - 테스트 실행 → 여전히 성공 확인    │
└─────────────────────────────────────────┘
              ↓
         (반복)
```

### 2.2 TDD 실습 예제

#### 예제 1: 기본 덧셈 기능

**Step 1: RED - 실패하는 테스트 작성**

```javascript
// src/js/__tests__/calculator.test.js
import { Calculator } from '../calculator.js';

describe('Calculator - 기본 연산', () => {
  let calculator;

  beforeEach(() => {
    calculator = new Calculator();
  });

  test('두 숫자를 더할 수 있다', () => {
    // Given: 계산기에 5와 3을 입력
    calculator.input('5');
    calculator.input('+');
    calculator.input('3');
    
    // When: 계산 실행
    const result = calculator.calculate();
    
    // Then: 결과는 8이어야 함
    expect(result).toBe(8);
  });
});
```

**실행 결과**: ❌ FAIL (Calculator 클래스가 없음)

**Step 2: GREEN - 최소한의 코드로 테스트 통과**

```javascript
// src/js/calculator.js
export class Calculator {
  constructor() {
    this.expression = '';
  }

  input(value) {
    this.expression += value;
  }

  calculate() {
    // 최소한의 구현
    return eval(this.expression);
  }
}
```

**실행 결과**: ✅ PASS

**Step 3: REFACTOR - 코드 개선 (SOLID 적용)**

```javascript
// src/js/calculator.js
export class Calculator {
  constructor(evaluator = new MathEvaluator()) {
    this.expression = '';
    this.evaluator = evaluator; // Dependency Injection (SOLID - D)
  }

  input(value) {
    this.expression += value;
  }

  calculate() {
    return this.evaluator.evaluate(this.expression);
  }

  clear() {
    this.expression = '';
  }
}

// 단일 책임 원칙 (SOLID - S): 평가 로직 분리
export class MathEvaluator {
  evaluate(expression) {
    // eval 대신 안전한 파싱 사용
    return math.evaluate(expression);
  }
}
```

**실행 결과**: ✅ PASS (리팩토링 후에도 테스트 통과)

#### 예제 2: 삼각함수 (각도 모드)

**Step 1: RED - 테스트 작성**

```javascript
describe('Calculator - 삼각함수', () => {
  test('DEG 모드에서 sin(30)은 0.5여야 한다', () => {
    // Given
    calculator.setAngleMode('DEG');
    calculator.input('sin(30)');
    
    // When
    const result = calculator.calculate();
    
    // Then
    expect(result).toBeCloseTo(0.5, 5);
  });

  test('RAD 모드에서 sin(π/6)은 0.5여야 한다', () => {
    // Given
    calculator.setAngleMode('RAD');
    calculator.input('sin(π/6)');
    
    // When
    const result = calculator.calculate();
    
    // Then
    expect(result).toBeCloseTo(0.5, 5);
  });
});
```

**Step 2: GREEN - 구현**

```javascript
export class Calculator {
  constructor(evaluator = new MathEvaluator()) {
    this.expression = '';
    this.evaluator = evaluator;
    this.angleMode = 'DEG'; // 기본값
  }

  setAngleMode(mode) {
    if (!['DEG', 'RAD'].includes(mode)) {
      throw new Error('Invalid angle mode');
    }
    this.angleMode = mode;
    this.evaluator.setAngleMode(mode);
  }

  // ... 기타 메서드
}

export class MathEvaluator {
  constructor() {
    this.angleMode = 'DEG';
  }

  setAngleMode(mode) {
    this.angleMode = mode;
  }

  evaluate(expression) {
    const scope = this.createScope();
    return math.evaluate(expression, scope);
  }

  createScope() {
    return {
      sin: (x) => this.angleMode === 'DEG' 
        ? math.sin(math.unit(x, 'deg')) 
        : math.sin(x),
      cos: (x) => this.angleMode === 'DEG' 
        ? math.cos(math.unit(x, 'deg')) 
        : math.cos(x),
      tan: (x) => this.angleMode === 'DEG' 
        ? math.tan(math.unit(x, 'deg')) 
        : math.tan(x),
      π: math.pi,
    };
  }
}
```

**Step 3: REFACTOR - 전략 패턴 적용**

```javascript
// 개방-폐쇄 원칙 (SOLID - O): 새로운 각도 모드 추가 시 기존 코드 수정 불필요
export class AngleModeStrategy {
  convertAngle(angle) {
    throw new Error('Must be implemented by subclass');
  }
}

export class DegreeStrategy extends AngleModeStrategy {
  convertAngle(angle) {
    return math.unit(angle, 'deg');
  }
}

export class RadianStrategy extends AngleModeStrategy {
  convertAngle(angle) {
    return angle; // 라디안은 변환 불필요
  }
}

export class MathEvaluator {
  constructor() {
    this.angleStrategy = new DegreeStrategy();
  }

  setAngleMode(mode) {
    this.angleStrategy = mode === 'DEG' 
      ? new DegreeStrategy() 
      : new RadianStrategy();
  }

  evaluate(expression) {
    const scope = this.createScope();
    return math.evaluate(expression, scope);
  }

  createScope() {
    return {
      sin: (x) => math.sin(this.angleStrategy.convertAngle(x)),
      cos: (x) => math.cos(this.angleStrategy.convertAngle(x)),
      tan: (x) => math.tan(this.angleStrategy.convertAngle(x)),
      π: math.pi,
    };
  }
}
```

### 2.3 TDD 체크리스트

새로운 기능을 구현할 때마다 다음을 확인하세요:

- [ ] **테스트 먼저 작성했는가?**
- [ ] **테스트가 실패하는 것을 확인했는가?** (RED)
- [ ] **최소한의 코드로 테스트를 통과시켰는가?** (GREEN)
- [ ] **코드를 리팩토링했는가?** (REFACTOR)
- [ ] **리팩토링 후에도 모든 테스트가 통과하는가?**
- [ ] **테스트 커버리지가 충분한가?** (최소 80%)

---

## 3. SOLID 원칙

### 3.1 S - Single Responsibility Principle (단일 책임 원칙)

> 클래스는 하나의 책임만 가져야 하며, 변경의 이유도 하나여야 한다.

#### ❌ 나쁜 예: 여러 책임을 가진 클래스

```javascript
class Calculator {
  constructor() {
    this.expression = '';
    this.history = [];
  }

  // 책임 1: 계산
  calculate() {
    const result = eval(this.expression);
    this.saveToHistory(this.expression, result);
    this.saveToLocalStorage();
    this.updateDisplay(result);
    return result;
  }

  // 책임 2: 히스토리 관리
  saveToHistory(expr, result) { /* ... */ }
  getHistory() { /* ... */ }

  // 책임 3: 저장소 관리
  saveToLocalStorage() { /* ... */ }
  loadFromLocalStorage() { /* ... */ }

  // 책임 4: UI 업데이트
  updateDisplay(result) { /* ... */ }
}
```

#### ✅ 좋은 예: 단일 책임으로 분리

```javascript
// 책임 1: 계산만 담당
class Calculator {
  constructor(evaluator) {
    this.expression = '';
    this.evaluator = evaluator;
  }

  input(value) {
    this.expression += value;
  }

  calculate() {
    return this.evaluator.evaluate(this.expression);
  }

  clear() {
    this.expression = '';
  }
}

// 책임 2: 히스토리 관리만 담당
class CalculationHistory {
  constructor(maxItems = 50) {
    this.items = [];
    this.maxItems = maxItems;
  }

  add(expression, result) {
    this.items.unshift({ expression, result, timestamp: Date.now() });
    if (this.items.length > this.maxItems) {
      this.items.pop();
    }
  }

  getAll() {
    return [...this.items];
  }

  clear() {
    this.items = [];
  }
}

// 책임 3: 저장소 관리만 담당
class HistoryStorage {
  constructor(storageKey = 'calculator_history') {
    this.storageKey = storageKey;
  }

  save(history) {
    localStorage.setItem(this.storageKey, JSON.stringify(history));
  }

  load() {
    const data = localStorage.getItem(this.storageKey);
    return data ? JSON.parse(data) : [];
  }
}

// 책임 4: UI 업데이트만 담당
class DisplayManager {
  constructor(expressionElement, resultElement) {
    this.expressionElement = expressionElement;
    this.resultElement = resultElement;
  }

  updateExpression(expression) {
    this.expressionElement.textContent = expression;
  }

  updateResult(result) {
    this.resultElement.textContent = this.formatNumber(result);
  }

  formatNumber(number) {
    return new Intl.NumberFormat('ko-KR').format(number);
  }
}
```

### 3.2 O - Open/Closed Principle (개방-폐쇄 원칙)

> 확장에는 열려있고, 수정에는 닫혀있어야 한다.

#### ❌ 나쁜 예: 새로운 연산 추가 시 기존 코드 수정 필요

```javascript
class Calculator {
  calculate(operation, a, b) {
    if (operation === 'add') {
      return a + b;
    } else if (operation === 'subtract') {
      return a - b;
    } else if (operation === 'multiply') {
      return a * b;
    } else if (operation === 'divide') {
      return a / b;
    }
    // 새로운 연산 추가 시 이 메서드를 수정해야 함!
  }
}
```

#### ✅ 좋은 예: 전략 패턴으로 확장 가능하게

```javascript
// 연산 인터페이스
class Operation {
  execute(a, b) {
    throw new Error('Must be implemented');
  }
}

// 각 연산을 독립적인 클래스로
class AddOperation extends Operation {
  execute(a, b) {
    return a + b;
  }
}

class SubtractOperation extends Operation {
  execute(a, b) {
    return a - b;
  }
}

class MultiplyOperation extends Operation {
  execute(a, b) {
    return a * b;
  }
}

class DivideOperation extends Operation {
  execute(a, b) {
    if (b === 0) {
      throw new Error('Division by zero');
    }
    return a / b;
  }
}

// 새로운 연산 추가 (기존 코드 수정 없이 확장)
class PowerOperation extends Operation {
  execute(a, b) {
    return Math.pow(a, b);
  }
}

// Calculator는 수정 없이 새로운 연산 사용 가능
class Calculator {
  constructor() {
    this.operations = new Map();
    this.registerDefaultOperations();
  }

  registerDefaultOperations() {
    this.registerOperation('+', new AddOperation());
    this.registerOperation('-', new SubtractOperation());
    this.registerOperation('*', new MultiplyOperation());
    this.registerOperation('/', new DivideOperation());
  }

  registerOperation(symbol, operation) {
    this.operations.set(symbol, operation);
  }

  calculate(symbol, a, b) {
    const operation = this.operations.get(symbol);
    if (!operation) {
      throw new Error(`Unknown operation: ${symbol}`);
    }
    return operation.execute(a, b);
  }
}

// 사용
const calc = new Calculator();
calc.registerOperation('^', new PowerOperation()); // 확장
console.log(calc.calculate('^', 2, 3)); // 8
```

### 3.3 L - Liskov Substitution Principle (리스코프 치환 원칙)

> 자식 클래스는 부모 클래스를 대체할 수 있어야 한다.

#### ❌ 나쁜 예: 부모 클래스의 계약 위반

```javascript
class Storage {
  save(key, value) {
    localStorage.setItem(key, JSON.stringify(value));
  }

  load(key) {
    const data = localStorage.getItem(key);
    return JSON.parse(data);
  }
}

// LSP 위반: load 메서드의 반환 타입이 다름
class ReadOnlyStorage extends Storage {
  save(key, value) {
    throw new Error('Cannot save in read-only mode');
  }

  load(key) {
    // 부모는 객체를 반환하는데 자식은 문자열 반환
    return localStorage.getItem(key); // JSON.parse 안 함!
  }
}
```

#### ✅ 좋은 예: 부모 클래스의 계약 준수

```javascript
class Storage {
  save(key, value) {
    throw new Error('Must be implemented');
  }

  load(key) {
    throw new Error('Must be implemented');
  }
}

class LocalStorage extends Storage {
  save(key, value) {
    localStorage.setItem(key, JSON.stringify(value));
  }

  load(key) {
    const data = localStorage.getItem(key);
    return data ? JSON.parse(data) : null;
  }
}

class SessionStorage extends Storage {
  save(key, value) {
    sessionStorage.setItem(key, JSON.stringify(value));
  }

  load(key) {
    const data = sessionStorage.getItem(key);
    return data ? JSON.parse(data) : null;
  }
}

class MemoryStorage extends Storage {
  constructor() {
    super();
    this.data = new Map();
  }

  save(key, value) {
    this.data.set(key, value);
  }

  load(key) {
    return this.data.get(key) || null;
  }
}

// 모든 Storage 구현체는 동일하게 사용 가능
function saveHistory(storage, history) {
  storage.save('history', history); // 어떤 Storage든 동일하게 동작
}
```

### 3.4 I - Interface Segregation Principle (인터페이스 분리 원칙)

> 클라이언트는 사용하지 않는 인터페이스에 의존하면 안 된다.

#### ❌ 나쁜 예: 비대한 인터페이스

```javascript
class Calculator {
  // 기본 계산기는 이 모든 메서드가 필요 없음
  add(a, b) { }
  subtract(a, b) { }
  multiply(a, b) { }
  divide(a, b) { }
  sin(x) { }
  cos(x) { }
  tan(x) { }
  log(x) { }
  ln(x) { }
  sqrt(x) { }
  power(a, b) { }
  factorial(n) { }
  // ... 수십 개의 메서드
}

// 기본 계산기는 삼각함수가 필요 없는데 구현해야 함
class BasicCalculator extends Calculator {
  sin(x) {
    throw new Error('Not supported');
  }
  cos(x) {
    throw new Error('Not supported');
  }
  // ...
}
```

#### ✅ 좋은 예: 인터페이스 분리

```javascript
// 기본 연산만 필요한 인터페이스
class BasicOperations {
  add(a, b) { throw new Error('Must be implemented'); }
  subtract(a, b) { throw new Error('Must be implemented'); }
  multiply(a, b) { throw new Error('Must be implemented'); }
  divide(a, b) { throw new Error('Must be implemented'); }
}

// 삼각함수 인터페이스
class TrigonometricOperations {
  sin(x) { throw new Error('Must be implemented'); }
  cos(x) { throw new Error('Must be implemented'); }
  tan(x) { throw new Error('Must be implemented'); }
}

// 로그 함수 인터페이스
class LogarithmicOperations {
  log(x) { throw new Error('Must be implemented'); }
  ln(x) { throw new Error('Must be implemented'); }
}

// 기본 계산기: 기본 연산만 구현
class BasicCalculator extends BasicOperations {
  add(a, b) { return a + b; }
  subtract(a, b) { return a - b; }
  multiply(a, b) { return a * b; }
  divide(a, b) { return a / b; }
}

// 과학 계산기: 필요한 인터페이스만 조합
class ScientificCalculator {
  constructor() {
    this.basicOps = new BasicCalculatorImpl();
    this.trigOps = new TrigonometricCalculatorImpl();
    this.logOps = new LogarithmicCalculatorImpl();
  }

  // 위임 패턴
  add(a, b) { return this.basicOps.add(a, b); }
  sin(x) { return this.trigOps.sin(x); }
  log(x) { return this.logOps.log(x); }
}
```

### 3.5 D - Dependency Inversion Principle (의존성 역전 원칙)

> 고수준 모듈은 저수준 모듈에 의존하면 안 되며, 둘 다 추상화에 의존해야 한다.

#### ❌ 나쁜 예: 구체적인 구현에 의존

```javascript
class Calculator {
  constructor() {
    // 구체적인 LocalStorage에 직접 의존
    this.storage = new LocalStorage();
    this.evaluator = new MathJsEvaluator();
  }

  saveHistory(history) {
    // LocalStorage에 강하게 결합됨
    this.storage.save('history', history);
  }

  calculate(expression) {
    // MathJsEvaluator에 강하게 결합됨
    return this.evaluator.evaluate(expression);
  }
}
```

#### ✅ 좋은 예: 추상화에 의존 (의존성 주입)

```javascript
// 추상화된 인터페이스
class IStorage {
  save(key, value) { throw new Error('Must be implemented'); }
  load(key) { throw new Error('Must be implemented'); }
}

class IEvaluator {
  evaluate(expression) { throw new Error('Must be implemented'); }
}

// 구체적인 구현
class LocalStorageAdapter extends IStorage {
  save(key, value) {
    localStorage.setItem(key, JSON.stringify(value));
  }

  load(key) {
    const data = localStorage.getItem(key);
    return data ? JSON.parse(data) : null;
  }
}

class MathJsEvaluator extends IEvaluator {
  evaluate(expression) {
    return math.evaluate(expression);
  }
}

// Calculator는 추상화에만 의존
class Calculator {
  constructor(storage, evaluator) {
    // 의존성 주입: 구체적인 구현이 아닌 인터페이스에 의존
    if (!(storage instanceof IStorage)) {
      throw new Error('storage must implement IStorage');
    }
    if (!(evaluator instanceof IEvaluator)) {
      throw new Error('evaluator must implement IEvaluator');
    }

    this.storage = storage;
    this.evaluator = evaluator;
  }

  saveHistory(history) {
    this.storage.save('history', history);
  }

  calculate(expression) {
    return this.evaluator.evaluate(expression);
  }
}

// 사용: 의존성을 외부에서 주입
const storage = new LocalStorageAdapter();
const evaluator = new MathJsEvaluator();
const calculator = new Calculator(storage, evaluator);

// 테스트 시 Mock 객체로 쉽게 교체 가능
class MockStorage extends IStorage {
  constructor() {
    super();
    this.data = new Map();
  }
  save(key, value) { this.data.set(key, value); }
  load(key) { return this.data.get(key); }
}

const mockStorage = new MockStorage();
const testCalculator = new Calculator(mockStorage, evaluator);
```

---

## 4. 프로젝트 아키텍처

### 4.1 레이어드 아키텍처

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (UI Components, Event Handlers)        │
│  - main.js                              │
│  - DOM manipulation                     │
└─────────────────────────────────────────┘
              ↓ (의존)
┌─────────────────────────────────────────┐
│         Application Layer               │
│  (Use Cases, Coordinators)              │
│  - CalculatorController                 │
│  - HistoryController                    │
└─────────────────────────────────────────┘
              ↓ (의존)
┌─────────────────────────────────────────┐
│         Domain Layer                    │
│  (Business Logic, Entities)             │
│  - Calculator                           │
│  - CalculationHistory                   │
│  - MathEvaluator                        │
└─────────────────────────────────────────┘
              ↓ (의존)
┌─────────────────────────────────────────┐
│         Infrastructure Layer            │
│  (External Services, Storage)           │
│  - LocalStorageAdapter                  │
│  - MathJsAdapter                        │
└─────────────────────────────────────────┘
```

### 4.2 디렉토리 구조 (SOLID 적용)

```
src/js/
├── domain/                    # 도메인 레이어 (비즈니스 로직)
│   ├── calculator/
│   │   ├── Calculator.js
│   │   ├── MathEvaluator.js
│   │   ├── AngleModeStrategy.js
│   │   └── __tests__/
│   │       ├── Calculator.test.js
│   │       ├── MathEvaluator.test.js
│   │       └── AngleModeStrategy.test.js
│   ├── history/
│   │   ├── CalculationHistory.js
│   │   └── __tests__/
│   │       └── CalculationHistory.test.js
│   └── unit-converter/
│       ├── UnitConverter.js
│       ├── ConversionStrategy.js
│       └── __tests__/
│           └── UnitConverter.test.js
├── infrastructure/            # 인프라 레이어 (외부 의존성)
│   ├── storage/
│   │   ├── IStorage.js       # 인터페이스
│   │   ├── LocalStorageAdapter.js
│   │   ├── SessionStorageAdapter.js
│   │   └── __tests__/
│   │       └── LocalStorageAdapter.test.js
│   └── evaluator/
│       ├── IEvaluator.js
│       ├── MathJsAdapter.js
│       └── __tests__/
│           └── MathJsAdapter.test.js
├── application/               # 애플리케이션 레이어 (유스케이스)
│   ├── CalculatorController.js
│   ├── HistoryController.js
│   └── __tests__/
│       ├── CalculatorController.test.js
│       └── HistoryController.test.js
├── presentation/              # 프레젠테이션 레이어 (UI)
│   ├── DisplayManager.js
│   ├── EventHandler.js
│   └── __tests__/             # 통합 테스트
│       └── integration.test.js
└── main.js                    # 앱 진입점
```

---

## 5. 코딩 컨벤션

### 5.1 네이밍 규칙

```javascript
// 클래스: PascalCase
class Calculator { }
class MathEvaluator { }

// 함수/메서드: camelCase
function calculateResult() { }
calculator.addDigit();

// 상수: UPPER_SNAKE_CASE
const MAX_HISTORY_ITEMS = 50;
const DEFAULT_ANGLE_MODE = 'DEG';

// 변수: camelCase
let currentExpression = '';
const angleMode = 'RAD';

// Private 멤버: _ 접두사
class Calculator {
  constructor() {
    this._expression = '';
  }

  _validateExpression() { }
}

// 인터페이스: I 접두사 (선택사항)
class IStorage { }
class IEvaluator { }
```

### 5.2 파일 구조

```javascript
// 1. Import 문
import { math } from 'mathjs';
import { IStorage } from '../infrastructure/storage/IStorage.js';

// 2. 상수 정의
const MAX_DECIMAL_PLACES = 10;
const ERROR_MESSAGES = {
  DIVISION_BY_ZERO: '0으로 나눌 수 없습니다',
};

// 3. 클래스 정의
export class Calculator {
  // 3.1 생성자
  constructor(evaluator) {
    this.evaluator = evaluator;
    this.expression = '';
  }

  // 3.2 Public 메서드
  calculate() {
    return this.evaluator.evaluate(this.expression);
  }

  // 3.3 Private 메서드
  _validateExpression() {
    // ...
  }
}

// 4. 유틸리티 함수 (필요시)
export function formatNumber(number) {
  return new Intl.NumberFormat('ko-KR').format(number);
}
```

### 5.3 JSDoc 주석

```javascript
/**
 * 수학 표현식을 평가하는 계산기 클래스
 * 
 * @class
 * @example
 * const calc = new Calculator(new MathJsEvaluator());
 * calc.input('5 + 3');
 * const result = calc.calculate(); // 8
 */
export class Calculator {
  /**
   * Calculator 생성자
   * 
   * @param {IEvaluator} evaluator - 표현식 평가기
   * @throws {Error} evaluator가 IEvaluator를 구현하지 않은 경우
   */
  constructor(evaluator) {
    // ...
  }

  /**
   * 현재 표현식을 계산하여 결과 반환
   * 
   * @returns {number} 계산 결과
   * @throws {Error} 표현식이 유효하지 않은 경우
   * 
   * @example
   * calculator.input('2 + 2');
   * const result = calculator.calculate(); // 4
   */
  calculate() {
    // ...
  }
}
```

---

## 6. 테스트 가이드

### 6.1 테스트 구조

```javascript
describe('Calculator', () => {
  // 테스트 스위트: 관련된 테스트들을 그룹화

  describe('기본 연산', () => {
    // 중첩된 테스트 스위트: 기능별로 세분화

    let calculator;

    beforeEach(() => {
      // 각 테스트 전에 실행: 초기화
      calculator = new Calculator(new MathJsEvaluator());
    });

    afterEach(() => {
      // 각 테스트 후에 실행: 정리
      calculator = null;
    });

    test('두 숫자를 더할 수 있다', () => {
      // Given (준비): 테스트 조건 설정
      calculator.input('5');
      calculator.input('+');
      calculator.input('3');

      // When (실행): 테스트할 동작 수행
      const result = calculator.calculate();

      // Then (검증): 결과 확인
      expect(result).toBe(8);
    });

    test('0으로 나누면 에러를 발생시킨다', () => {
      // Given
      calculator.input('5 / 0');

      // When & Then
      expect(() => calculator.calculate()).toThrow('0으로 나눌 수 없습니다');
    });
  });
});
```

### 6.2 테스트 커버리지 목표

```javascript
// package.json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage"
  },
  "jest": {
    "coverageThreshold": {
      "global": {
        "branches": 80,
        "functions": 80,
        "lines": 80,
        "statements": 80
      }
    }
  }
}
```

### 6.3 Mock 및 Stub 사용

```javascript
// Mock: 의존성을 가짜 객체로 대체
describe('Calculator with Mock', () => {
  test('계산 결과를 저장소에 저장한다', () => {
    // Mock Storage 생성
    const mockStorage = {
      save: jest.fn(),
      load: jest.fn(),
    };

    const calculator = new Calculator(
      new MathJsEvaluator(),
      mockStorage
    );

    calculator.input('5 + 3');
    calculator.calculate();
    calculator.saveToHistory();

    // Mock이 올바르게 호출되었는지 검증
    expect(mockStorage.save).toHaveBeenCalledWith(
      'history',
      expect.arrayContaining([
        expect.objectContaining({
          expression: '5 + 3',
          result: 8
        })
      ])
    );
  });
});
```

### 6.4 테스트 네이밍 컨벤션

```javascript
// 패턴: "should [expected behavior] when [condition]"

test('should return 8 when adding 5 and 3', () => { });
test('should throw error when dividing by zero', () => { });
test('should save history when calculation completes', () => { });

// 또는 한글로
test('5와 3을 더하면 8을 반환한다', () => { });
test('0으로 나누면 에러를 발생시킨다', () => { });
test('계산 완료 시 히스토리에 저장한다', () => { });
```

---

## 7. 코드 리뷰 체크리스트

### 7.1 TDD 준수 확인

- [ ] 모든 새로운 기능에 대한 테스트가 작성되었는가?
- [ ] 테스트가 기능 구현 전에 작성되었는가?
- [ ] 모든 테스트가 통과하는가?
- [ ] 테스트 커버리지가 80% 이상인가?
- [ ] 엣지 케이스에 대한 테스트가 포함되어 있는가?

### 7.2 SOLID 원칙 준수 확인

- [ ] **S**: 각 클래스가 단일 책임만 가지는가?
- [ ] **O**: 새로운 기능 추가 시 기존 코드 수정이 필요 없는가?
- [ ] **L**: 자식 클래스가 부모 클래스를 대체할 수 있는가?
- [ ] **I**: 클라이언트가 사용하지 않는 메서드에 의존하지 않는가?
- [ ] **D**: 구체적인 구현이 아닌 추상화에 의존하는가?

### 7.3 코드 품질 확인

- [ ] 코드가 읽기 쉽고 이해하기 쉬운가?
- [ ] 적절한 주석이 작성되어 있는가?
- [ ] 네이밍이 명확하고 일관성 있는가?
- [ ] 중복 코드가 제거되었는가?
- [ ] 매직 넘버가 상수로 정의되어 있는가?

---

## 8. 참고 자료

### 8.1 TDD 학습 자료
- [Test Driven Development: By Example](https://www.amazon.com/Test-Driven-Development-Kent-Beck/dp/0321146530) - Kent Beck
- [Growing Object-Oriented Software, Guided by Tests](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627)

### 8.2 SOLID 원칙 학습 자료
- [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882) - Robert C. Martin
- [Agile Software Development, Principles, Patterns, and Practices](https://www.amazon.com/Software-Development-Principles-Patterns-Practices/dp/0135974445) - Robert C. Martin

### 8.3 JavaScript 테스팅
- [Jest Documentation](https://jestjs.io/docs/getting-started)
- [Testing JavaScript](https://testingjavascript.com/) - Kent C. Dodds

---

**문서 버전**: 1.0  
**최종 업데이트**: 2025-12-23  
**작성자**: Development Team
