# Contributing to Scientific Calculator

First off, thank you for considering contributing to this project! 🎉

This is a portfolio project, but contributions, suggestions, and feedback are always welcome.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Process](#development-process)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Requirements](#testing-requirements)

## 📜 Code of Conduct

This project adheres to a Code of Conduct. By participating, you are expected to uphold this code.

- Be respectful and inclusive
- Welcome newcomers and help them learn
- Focus on what is best for the community
- Show empathy towards other community members

## 🤝 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce** the behavior
- **Expected behavior**
- **Actual behavior**
- **Screenshots** if applicable
- **Environment** (browser, OS, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Clear title and description**
- **Use case** - why is this enhancement needed?
- **Proposed solution**
- **Alternatives considered**

### Code Contributions

1. Fork the repository
2. Create a feature branch
3. Make your changes following our coding standards
4. Write/update tests
5. Ensure all tests pass
6. Submit a pull request

## 🔄 Development Process

### 1. Setup Development Environment

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/calculator.git
cd calculator

# Install dependencies
npm install

# Run development server
npm run dev
```

### 2. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Follow TDD (Test-Driven Development)

**⚠️ IMPORTANT**: All core logic MUST be developed using TDD.

```javascript
// 1. RED: Write a failing test
test('should add two numbers', () => {
  calculator.input('5 + 3');
  expect(calculator.calculate()).toBe(8);
});

// 2. GREEN: Make it pass
class Calculator {
  calculate() {
    return eval(this.expression);
  }
}

// 3. REFACTOR: Improve the code
class Calculator {
  constructor(evaluator) {
    this.evaluator = evaluator; // Dependency Injection
  }
  
  calculate() {
    return this.evaluator.evaluate(this.expression);
  }
}
```

### 4. Apply SOLID Principles

Ensure your code follows SOLID principles:

- **S**ingle Responsibility: One class, one responsibility
- **O**pen/Closed: Open for extension, closed for modification
- **L**iskov Substitution: Subtypes must be substitutable
- **I**nterface Segregation: Many specific interfaces over one general
- **D**ependency Inversion: Depend on abstractions, not concretions

### 5. Run Tests

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Check coverage
npm run test:coverage
```

### 6. Run Linting

```bash
# Check for linting errors
npm run lint

# Auto-fix linting errors
npm run lint:fix
```

## 🔀 Pull Request Process

### Before Submitting

- [ ] All tests pass (`npm test`)
- [ ] Linting passes (`npm run lint`)
- [ ] Test coverage is maintained (80%+ for core logic)
- [ ] Code follows SOLID principles
- [ ] Documentation is updated
- [ ] Commit messages follow convention

### PR Checklist

1. **Update Documentation**
   - Update README.md if needed
   - Add/update JSDoc comments
   - Update relevant docs/ files

2. **Test Coverage**
   - Add tests for new features
   - Maintain 80%+ coverage for core logic
   - UI changes: document manual testing steps

3. **Code Quality**
   - Follow existing code style
   - Apply SOLID principles
   - Remove console.logs and debug code

4. **Commit Messages**
   ```
   <type>(<scope>): <subject>
   
   <body>
   
   <footer>
   ```
   
   Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] All tests pass
- [ ] New tests added
- [ ] Manual testing completed

## Checklist
- [ ] Code follows SOLID principles
- [ ] Tests written using TDD
- [ ] Documentation updated
- [ ] Linting passes
```

## 📏 Coding Standards

### JavaScript Style Guide

```javascript
// ✅ Good
class Calculator {
  constructor(evaluator) {
    this.evaluator = evaluator;
  }

  calculate(expression) {
    return this.evaluator.evaluate(expression);
  }
}

// ❌ Bad
class calculator {
  constructor() {
    this.eval = eval; // Don't use eval directly
  }

  calc(expr) { // Use descriptive names
    return this.eval(expr);
  }
}
```

### Naming Conventions

- **Classes**: PascalCase (`Calculator`, `MathEvaluator`)
- **Functions/Methods**: camelCase (`calculate`, `addToHistory`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_HISTORY_ITEMS`)
- **Private members**: `_` prefix (`_validateInput`)

### File Organization

```javascript
// 1. Imports
import { math } from 'mathjs';

// 2. Constants
const MAX_ITEMS = 50;

// 3. Class definition
export class Calculator {
  // 3.1 Constructor
  constructor() { }

  // 3.2 Public methods
  calculate() { }

  // 3.3 Private methods
  _validate() { }
}

// 4. Helper functions
export function formatNumber(num) { }
```

## 🧪 Testing Requirements

### TDD Scope

**✅ MUST use TDD** (Red-Green-Refactor):
- Domain layer (`src/js/domain/`)
- Infrastructure layer (`src/js/infrastructure/`)
- Application layer (`src/js/application/`)

**❌ Manual testing only**:
- Presentation layer (`src/js/presentation/`)
- UI components
- Animations

### Test Structure

```javascript
describe('Feature Name', () => {
  // Setup
  let instance;

  beforeEach(() => {
    instance = new ClassName();
  });

  // Tests using Given-When-Then
  test('should do something when condition', () => {
    // Given: Setup
    const input = 'test';

    // When: Execute
    const result = instance.method(input);

    // Then: Assert
    expect(result).toBe('expected');
  });
});
```

### Coverage Requirements

- **Domain Layer**: 80%+ coverage
- **Infrastructure Layer**: 80%+ coverage
- **Application Layer**: 80%+ coverage
- **Overall**: 80%+ coverage

## 🎨 Code Review Checklist

Reviewers will check:

### TDD Compliance
- [ ] Tests written before implementation
- [ ] Tests follow Given-When-Then pattern
- [ ] Coverage meets requirements

### SOLID Principles
- [ ] Single Responsibility: Each class has one job
- [ ] Open/Closed: Extensible without modification
- [ ] Liskov Substitution: Subtypes are substitutable
- [ ] Interface Segregation: Small, focused interfaces
- [ ] Dependency Inversion: Depends on abstractions

### Code Quality
- [ ] No code duplication
- [ ] Clear, descriptive names
- [ ] Proper error handling
- [ ] JSDoc comments for public APIs
- [ ] No magic numbers

### Testing
- [ ] All tests pass
- [ ] Edge cases covered
- [ ] Error cases tested
- [ ] Mock dependencies properly

## 📞 Questions?

Feel free to:
- Open an issue for discussion
- Ask questions in pull requests
- Reach out to the maintainer

## 🙏 Thank You!

Your contributions make this project better. Thank you for taking the time to contribute!

---

**Happy Coding!** 🚀
