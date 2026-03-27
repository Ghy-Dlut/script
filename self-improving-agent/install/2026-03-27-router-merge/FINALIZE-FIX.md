# Finalize Helper Fix

A post-install fix was applied after the first archive upload.

Changes:
- `Finalize-KnowledgeRoutingTurn.ps1` now imports `Common.ps1` before calling `Resolve-SkillScriptPath`.
- Added `Finalize-KnowledgeRoutingTurn.Tests.ps1`.
- Full router-merge test suite now passes: `11/11`.

Updated local subrepo commit:
- `0bd98cf`

Updated archive:
- `archive-v2.zip.base64.txt`
- SHA256 of original zip payload: `FB1ADC8791E5F715113D749B9B4BFC87D3538E306AE426B1827540C84C016655`
