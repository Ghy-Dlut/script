# duplicate-learning-dedup-20260327_234200

- Purpose: prevent exact duplicate pending learning entries from being appended twice.
- Root cause: the same lesson could be finalized once directly through self-improving and again through router finalize, producing two different ids with identical summary/details.
- Changed files:
  - Write-LearningEntry.ps1
  - Write-LearningEntry.Tests.ps1
- Verification:
  - Invoke-Pester -Path C:\Users\55451\OneDrive\scrips\tests\router-merge\Write-LearningEntry.Tests.ps1
  - Invoke-Pester -Path C:\Users\55451\OneDrive\scrips\tests\router-merge
