# 2026-03-27 Legacy Forwarders And Refresh

This snapshot captures the review-driven fixes for the router-first self-improving install.

## Scope

- Fixed both legacy `.codex` finalize forwarders so they execute and delegate into the canonical `.agents` scripts.
- Changed managed-section refresh logic so stale router and self-improvement blocks are automatically replaced even when `-ForceSection` is not passed.
- Added regression tests that execute the legacy finalize forwarders instead of only checking their text.

## Files

- `files/Users/55451/.codex/skills/workspace-knowledge-router/scripts/Finalize-KnowledgeRoutingTurn.ps1`
- `files/Users/55451/.codex/skills/self-improving-agent/scripts/Finalize-SelfImprovementTurn.ps1`
- `files/Users/55451/.agents/skills/workspace-knowledge-router/scripts/Common.ps1`
- `files/Users/55451/.agents/skills/self-improving-agent/scripts/Apply-WorkspaceSetup.ps1`
- `files/Users/55451/OneDrive/scrips/tests/router-merge/CompatibilityForwarders.Tests.ps1`
- `files/Users/55451/OneDrive/scrips/tests/router-merge/Common.Tests.ps1`
- `files/Users/55451/OneDrive/scrips/tests/router-merge/Apply-WorkspaceKnowledgeSetup.Tests.ps1`
- `files/Users/55451/OneDrive/scrips/tests/router-merge/Apply-WorkspaceSetup.Tests.ps1`

## Verification

- `Invoke-Pester -Path C:\Users\55451\OneDrive\scrips\tests\router-merge\CompatibilityForwarders.Tests.ps1,C:\Users\55451\OneDrive\scrips\tests\router-merge\Common.Tests.ps1,C:\Users\55451\OneDrive\scrips\tests\router-merge\Apply-WorkspaceKnowledgeSetup.Tests.ps1,C:\Users\55451\OneDrive\scrips\tests\router-merge\Apply-WorkspaceSetup.Tests.ps1`
- Result: `12 passed, 0 failed`
- `Invoke-Pester -Path C:\Users\55451\OneDrive\scrips\tests\router-merge`
- Result: `21 passed, 0 failed`

## Backup

- Timestamped local backup: `C:\Users\55451\OneDrive\scrips\skill_backups\router_review_fix_20260327_221344`
