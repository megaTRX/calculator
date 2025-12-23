# TDD 규칙  
  
이 프로젝트의 **코어 로직만** TDD로 구현합니다. UI 테스트는 자동화하지 않습니다.  
  
## TDD 적용 대상  
  
### ? TDD 필수 (자동화된 단위 테스트)  
- 계산 로직 (domain/calculator/)  
- 히스토리 관리 (domain/history/)  
- 스토리지 (infrastructure/storage/)  
- 평가기 (infrastructure/evaluator/)  
- 단위 변환 (domain/unit-converter/)  
- 애플리케이션 컨트롤러 (application/)  
  
### ? TDD 제외 (수동 테스트만)  
- UI 컴포넌트 (presentation/)  
- DOM 조작 로직  
- 이벤트 핸들러  
- 애니메이션 효과  
  
## 핵심 원칙  
  
1. Red-Green-Refactor 사이클 준수  
2. 코어 로직 테스트 커버리지 80%% 이상  
3. 테스트 없는 코어 로직은 병합 불가  
4. UI는 수동 테스트로 검증  
  
자세한 내용은 docs/DEVELOPMENT_GUIDE.md를 참조하세요. 
