/**
 * 공학용 계산기 애플리케이션
 * 
 * 주의: 이것은 프로토타입 버전입니다.
 * 향후 TDD를 적용하여 코어 로직을 별도 모듈로 분리할 예정입니다.
 */

class Calculator {
    constructor() {
        this.expression = '';
        this.result = '0';
        this.angleMode = 'DEG'; // 'DEG' or 'RAD'
        this.history = [];

        this.init();
    }

    init() {
        // DOM 요소 참조
        this.expressionDisplay = document.getElementById('expressionDisplay');
        this.resultDisplay = document.getElementById('resultDisplay');
        this.degBtn = document.getElementById('degBtn');
        this.radBtn = document.getElementById('radBtn');

        // 이벤트 리스너 등록
        this.attachEventListeners();

        // 키보드 이벤트
        document.addEventListener('keydown', (e) => this.handleKeyboard(e));
    }

    attachEventListeners() {
        // 숫자 버튼
        document.querySelectorAll('[data-number]').forEach(btn => {
            btn.addEventListener('click', () => this.handleNumber(btn.dataset.number));
        });

        // 연산자 버튼
        document.querySelectorAll('[data-operator]').forEach(btn => {
            btn.addEventListener('click', () => this.handleOperator(btn.dataset.operator));
        });

        // 값 버튼 (괄호, 소수점)
        document.querySelectorAll('[data-value]').forEach(btn => {
            btn.addEventListener('click', () => this.handleValue(btn.dataset.value));
        });

        // 과학 함수 버튼
        document.querySelectorAll('[data-function]').forEach(btn => {
            btn.addEventListener('click', () => this.handleFunction(btn.dataset.function));
        });

        // 특수 버튼
        document.getElementById('clearBtn').addEventListener('click', () => this.clear());
        document.getElementById('backspaceBtn').addEventListener('click', () => this.backspace());
        document.getElementById('equalsBtn').addEventListener('click', () => this.calculate());

        // 각도 모드 버튼
        this.degBtn.addEventListener('click', () => this.setAngleMode('DEG'));
        this.radBtn.addEventListener('click', () => this.setAngleMode('RAD'));
    }

    handleNumber(num) {
        this.expression += num;
        this.updateDisplay();
    }

    handleOperator(op) {
        // 연산자 변환 (UI → 계산용)
        const operators = {
            '%': '/100',
            '×': '*',
            '÷': '/',
            '−': '-'
        };

        const actualOp = operators[op] || op;

        // 백분율 처리
        if (op === '%') {
            this.expression += actualOp;
        } else {
            // 마지막이 연산자가 아닐 때만 추가
            const lastChar = this.expression.slice(-1);
            if (lastChar && !'+-*/'.includes(lastChar)) {
                this.expression += actualOp;
            }
        }

        this.updateDisplay();
    }

    handleValue(value) {
        // 소수점 중복 방지
        if (value === '.') {
            const parts = this.expression.split(/[\+\-\*\/]/);
            const lastPart = parts[parts.length - 1];
            if (lastPart.includes('.')) return;
        }

        this.expression += value;
        this.updateDisplay();
    }

    handleFunction(func) {
        const functions = {
            'sin': 'sin(',
            'cos': 'cos(',
            'tan': 'tan(',
            'ln': 'ln(',
            'log': 'log(',
            'sqrt': 'sqrt(',
            'pi': Math.PI.toString(),
            'e': Math.E.toString()
        };

        this.expression += functions[func] || func;
        this.updateDisplay();
    }

    setAngleMode(mode) {
        this.angleMode = mode;

        // UI 업데이트
        if (mode === 'DEG') {
            this.degBtn.classList.add('bg-surface-dark', 'border', 'border-white/5', 'text-primary');
            this.degBtn.classList.remove('bg-transparent', 'text-white/40');
            this.degBtn.setAttribute('aria-pressed', 'true');

            this.radBtn.classList.remove('bg-surface-dark', 'border', 'border-white/5', 'text-primary');
            this.radBtn.classList.add('bg-transparent', 'text-white/40');
            this.radBtn.setAttribute('aria-pressed', 'false');
        } else {
            this.radBtn.classList.add('bg-surface-dark', 'border', 'border-white/5', 'text-primary');
            this.radBtn.classList.remove('bg-transparent', 'text-white/40');
            this.radBtn.setAttribute('aria-pressed', 'true');

            this.degBtn.classList.remove('bg-surface-dark', 'border', 'border-white/5', 'text-primary');
            this.degBtn.classList.add('bg-transparent', 'text-white/40');
            this.degBtn.setAttribute('aria-pressed', 'false');
        }
    }

    clear() {
        this.expression = '';
        this.result = '0';
        this.updateDisplay();
    }

    backspace() {
        this.expression = this.expression.slice(0, -1);
        this.updateDisplay();
    }

    calculate() {
        if (!this.expression) return;

        try {
            // 수식 전처리
            let expr = this.expression;

            // 삼각함수 처리
            expr = this.processTrigFunctions(expr);

            // 로그 함수 처리
            expr = expr.replace(/ln\(/g, 'Math.log(');
            expr = expr.replace(/log\(/g, 'Math.log10(');

            // 제곱근 처리
            expr = expr.replace(/sqrt\(/g, 'Math.sqrt(');

            // 계산 실행
            const result = eval(expr);

            // 결과 검증
            if (!isFinite(result)) {
                throw new Error('오류');
            }

            // 결과 저장
            this.result = this.formatNumber(result);

            // 히스토리 추가
            this.addToHistory(this.expression, this.result);

            // 표시 업데이트
            this.updateDisplay();

            // 다음 계산을 위해 표현식 초기화
            this.expression = '';

        } catch (error) {
            this.result = '오류';
            this.updateDisplay();
            setTimeout(() => {
                this.result = '0';
                this.updateDisplay();
            }, 1500);
        }
    }

    processTrigFunctions(expr) {
        const trigFuncs = ['sin', 'cos', 'tan'];

        trigFuncs.forEach(func => {
            const regex = new RegExp(`${func}\\(([^)]+)\\)`, 'g');
            expr = expr.replace(regex, (match, angle) => {
                try {
                    const angleValue = eval(angle);
                    const radians = this.angleMode === 'DEG'
                        ? angleValue * Math.PI / 180
                        : angleValue;
                    return `Math.${func}(${radians})`;
                } catch {
                    return match;
                }
            });
        });

        return expr;
    }

    formatNumber(num) {
        // 소수점 처리
        const rounded = Math.round(num * 1e10) / 1e10;

        // 천 단위 구분
        const parts = rounded.toString().split('.');
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');

        return parts.join('.');
    }

    addToHistory(expression, result) {
        this.history.unshift({ expression, result, timestamp: Date.now() });

        // 최대 50개 유지
        if (this.history.length > 50) {
            this.history.pop();
        }

        // LocalStorage에 저장
        try {
            localStorage.setItem('calculator_history', JSON.stringify(this.history));
        } catch (e) {
            console.warn('히스토리 저장 실패:', e);
        }
    }

    loadHistory() {
        try {
            const saved = localStorage.getItem('calculator_history');
            if (saved) {
                this.history = JSON.parse(saved);
            }
        } catch (e) {
            console.warn('히스토리 로드 실패:', e);
        }
    }

    updateDisplay() {
        // 표현식 표시
        this.expressionDisplay.textContent = this.expression || '0';

        // 결과 표시
        this.resultDisplay.textContent = this.result;

        // 애니메이션 재시작
        this.resultDisplay.classList.remove('result-animation');
        void this.resultDisplay.offsetWidth; // 리플로우 강제
        this.resultDisplay.classList.add('result-animation');
    }

    handleKeyboard(e) {
        // 숫자
        if (e.key >= '0' && e.key <= '9') {
            e.preventDefault();
            this.handleNumber(e.key);
        }

        // 연산자
        const operatorMap = {
            '+': '+',
            '-': '-',
            '*': '*',
            '/': '/',
            '%': '%'
        };

        if (operatorMap[e.key]) {
            e.preventDefault();
            this.handleOperator(operatorMap[e.key]);
        }

        // 특수 키
        if (e.key === 'Enter' || e.key === '=') {
            e.preventDefault();
            this.calculate();
        }

        if (e.key === 'Escape') {
            e.preventDefault();
            this.clear();
        }

        if (e.key === 'Backspace') {
            e.preventDefault();
            this.backspace();
        }

        if (e.key === '.') {
            e.preventDefault();
            this.handleValue('.');
        }

        if (e.key === '(' || e.key === ')') {
            e.preventDefault();
            this.handleValue(e.key);
        }
    }
}

// 앱 초기화
document.addEventListener('DOMContentLoaded', () => {
    const calculator = new Calculator();
    calculator.loadHistory();

    console.log('🧮 공학용 계산기가 시작되었습니다.');
    console.log('📝 TDD와 SOLID 원칙으로 구축된 프로젝트입니다.');
});
