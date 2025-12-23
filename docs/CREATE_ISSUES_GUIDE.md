# GitHub Issues 자동 생성 가이드

## ✅ 완료된 이슈

- **Issue #1**: [Phase 1] 프로젝트 초기 설정
  - URL: https://github.com/megaTRX/calculator/issues/1
  - Status: Created

## 📝 나머지 이슈 생성 방법

### 방법 1: GitHub CLI 사용 (권장)

아래 명령어들을 순서대로 실행하세요:

```bash
# Phase 2
gh issue create --title "[Phase 2] 인프라 레이어 구현 (TDD)" --body-file .github/issues/phase-2.md --assignee "@me"

# Phase 3
gh issue create --title "[Phase 3] 계산기 핵심 로직 구현 (TDD)" --body-file .github/issues/phase-3.md --assignee "@me"

# Phase 4
gh issue create --title "[Phase 4] 히스토리 관리 구현 (TDD)" --body-file .github/issues/phase-4.md --assignee "@me"

# Phase 5
gh issue create --title "[Phase 5] 애플리케이션 레이어 구현 (TDD)" --body-file .github/issues/phase-5.md --assignee "@me"

# Phase 6
gh issue create --title "[Phase 6] UI 구현 (수동 테스트)" --body-file .github/issues/phase-6.md --assignee "@me"

# Phase 7
gh issue create --title "[Phase 7] 메인 앱 통합 (수동 테스트)" --body-file .github/issues/phase-7.md --assignee "@me"

# Phase 8 (선택사항)
gh issue create --title "[Phase 8] 단위 변환 기능 구현 (TDD, 선택사항)" --body-file .github/issues/phase-8.md --assignee "@me"

# Phase 9
gh issue create --title "[Phase 9] 테스트 및 품질 보증" --body-file .github/issues/phase-9.md --assignee "@me"

# Phase 10
gh issue create --title "[Phase 10] 배포 및 문서화" --body-file .github/issues/phase-10.md --assignee "@me"
```

### 방법 2: GitHub 웹 UI 사용

1. https://github.com/megaTRX/calculator/issues 로 이동
2. "New issue" 클릭
3. `docs/GITHUB_ISSUES_TEMPLATE.md` 파일에서 해당 Phase의 내용 복사
4. Title과 Body에 붙여넣기
5. "Submit new issue" 클릭
6. Phase 2부터 Phase 10까지 반복

### 방법 3: 한 번에 모두 생성 (PowerShell)

```powershell
# 간단한 버전으로 한 번에 생성
$issues = @(
    @{title="[Phase 2] 인프라 레이어 구현 (TDD)"; body="Storage와 Evaluator 인프라 구현 (TDD)"},
    @{title="[Phase 3] 계산기 핵심 로직 구현 (TDD)"; body="Calculator 도메인 로직 구현 (TDD)"},
    @{title="[Phase 4] 히스토리 관리 구현 (TDD)"; body="계산 히스토리 관리 기능 구현 (TDD)"},
    @{title="[Phase 5] 애플리케이션 레이어 구현 (TDD)"; body="컨트롤러 레이어 구현 (TDD)"},
    @{title="[Phase 6] UI 구현 (수동 테스트)"; body="사용자 인터페이스 구현 (수동 테스트)"},
    @{title="[Phase 7] 메인 앱 통합 (수동 테스트)"; body="전체 앱 통합 (수동 테스트)"},
    @{title="[Phase 8] 단위 변환 기능 구현 (TDD, 선택사항)"; body="단위 변환 기능 추가 (선택사항)"},
    @{title="[Phase 9] 테스트 및 품질 보증"; body="종합 테스트 및 QA"},
    @{title="[Phase 10] 배포 및 문서화"; body="GitHub Pages 배포 및 문서 정리"}
)

foreach ($issue in $issues) {
    gh issue create --title $issue.title --body $issue.body --assignee "@me"
    Start-Sleep -Seconds 1
}
```

## 📋 이슈 생성 후 확인사항

각 이슈 생성 후:
1. ✅ 제목이 올바른지 확인
2. ✅ 작업 배경, 작업 내용, 인수 조건이 포함되었는지 확인
3. ✅ Assignee가 설정되었는지 확인
4. ✅ Labels 추가 (phase-X, tdd, domain 등)

## 🏷️ 권장 Labels

이슈 생성 후 다음 레이블을 추가하세요:

- `phase-1` ~ `phase-10`: Phase 번호
- `tdd`: TDD 적용 대상
- `manual-test`: 수동 테스트
- `domain`: 도메인 레이어
- `infrastructure`: 인프라 레이어
- `application`: 애플리케이션 레이어
- `ui`: UI 관련
- `testing`: 테스트 관련
- `deployment`: 배포 관련
- `documentation`: 문서 관련
- `enhancement`: 개선사항
- `optional`: 선택사항

## 📊 이슈 관리 팁

1. **Milestones 생성**: v1.0 MVP, v1.1 Enhancement 등
2. **Projects 사용**: GitHub Projects로 칸반 보드 구성
3. **우선순위 설정**: Priority labels (high, medium, low)
4. **진행 상태 추적**: In Progress, In Review, Done 등

## 🔗 관련 문서

- [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md) - 전체 구현 계획
- [GITHUB_ISSUES_TEMPLATE.md](GITHUB_ISSUES_TEMPLATE.md) - 상세 이슈 템플릿
- [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) - 개발 가이드
