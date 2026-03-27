# Programming Global Knowledge

This file stores high-value, cross-project learnings for the $category thread category.

## Usage
Read this file when the current thread is classified as $category.

## Auto-Promoted Learnings
<!-- knowledge:auto:start -->
### [LRN-20260327-008] Installed the router-led self-improving merge with .agents canonical roots, type-isolated global knowledge, and legacy .codex compatibility forwarders.
- Source thread: 019d2ea5-11be-7b51-ac11-ce91b77f9e25
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: medium priority; generalizable learning category; broad reuse language
- Reuse guidance: The installation now routes reads and writes by knowledge type, keeps only programming and academic-writing as shared global knowledge partitions under ~/.agents/knowledge-base, requires user confirmation before unsupported thread types access global knowledge, updates workspace and skill documentation to canonical ~/.agents/skills paths, and turns the tested legacy .codex entry scripts into compatibility forwarders to the canonical .agents implementations.

### [LRN-20260327-007] GitHub skill installs may need nested repo paths and treat installer --dest as a parent directory, not the final skill directory.
- Source thread: 019d2ea5-11be-7b51-ac11-ce91b77f9e25
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: User reviewed medium-value item and chose 提升 on 2026-03-27.
- Reuse guidance: When installing GitHub-hosted skills, verify whether the repository path needs a nested skill subdirectory and treat installer --dest as a parent destination path rather than the final skill folder.

### [LRN-20260312-001] Smithery skill refresh may install a renamed package instead of updating the original folder
- Source thread: 019d2fc6-f619-74b0-a5a7-f83ce8df19e3
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: medium priority; generalizable learning category; broad reuse language
- Reuse guidance: During a skills update check on 2026-03-12, running the official refresh command for marcelleon-doc-coauthoring from its Smithery well-known URL did not replace the existing ~/.agents/skills/marcelleon-doc-coauthoring folder. It installed a new ~/.agents/skills/smithery-ai-cli package and added a second lock entry. When refreshing Smithery-hosted skills without version hashes, verify the returned package name and lock file changes before assuming an in-place update occurred.

### [LRN-20260323-003] Validate tsx/esbuild autostart flows outside the Codex sandbox on Windows
- Source thread: 019d2fc6-f619-74b0-a5a7-f83ce8df19e3
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: medium priority; generalizable learning category; broad reuse language
- Reuse guidance: While simulating wechat-channel-agents autostart, the workspace sandbox caused npm/tsx startup to fail with Error [TransformError]: spawn EPERM from esbuild. The launcher logic itself was sound; the failure came from child-process spawning restrictions during in-sandbox verification. For Windows Node projects started through tsx/esbuild or similar spawn-heavy toolchains, verify startup/autostart behavior in an elevated or real desktop environment rather than only inside the Codex workspace sandbox.

### [LRN-20260325-002] codex-wechat service reinstall can leave duplicate bot instances; verify process tree and stop orphan nodes
- Source thread: 019d2fc6-f619-74b0-a5a7-f83ce8df19e3
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: medium priority; generalizable learning category; broad reuse language
- Reuse guidance: While changing CODEX_WECHAT_WORKSPACE_ALLOWLIST to empty to allow all directories, reinstalling the CodexWechatBackgroundService restarted the watcher-managed chain but left an older standalone node ./bin/codex-wechat.js start process alive. This creates a risk of duplicate message handling. After service restarts, verify the process tree contains exactly one watcher chain (Watch-CodexWechatService.ps1 -> Run-CodexWechatService.ps1 -> cmd.exe -> node.exe) and stop any orphan codex-wechat node/cmd pair before declaring the fix complete.

### [LRN-20260327-004] Knowledge routing must be type-isolated: only programming and academic-writing global knowledge bases remain; cross-type knowledge must not be linked or shared.
- Source thread: 019d2fc6-f619-74b0-a5a7-f83ce8df19e3
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: medium priority; generalizable learning category; broad reuse language
- Reuse guidance: User corrected the design on 2026-03-27. All operations should route by knowledge type. Only programming and academic-writing global knowledge bases should remain. If partitions differ only by global/project scope, related entries may link without double-writing; if partitions differ by knowledge type, similar content must still be stored independently with no sharing or cross-type linking. Historical migration should drop origin_refs in merged entries.

### [LRN-20260327-018] Harden Windows local automation actions with one-time tokens, named mutexes, exact process matching, and explicit schtasks exit-code checks.
- Source thread: 019d2e62-dc3e-79f3-983c-5570682cc28c
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: medium priority; generalizable learning category; broad reuse language
- Reuse guidance: While fixing the Codex store update automation on 2026-03-27, the reusable hardening pattern was: issue a fresh token for each toast action and reject mismatches; invalidate the token once the external update path begins; back file-observed locks with a named mutex instead of read-then-write lock files; match managed processes by exact allowlisted names and snapshot path rather than substrings; and treat schtasks.exe as successful only when LASTEXITCODE is zero, including a test-mode failure switch for regression coverage.

### [LRN-20260323-001] Use project-local runtime state for Codex-triggered startup scripts in this workspace
- Source thread: 019d2fc6-f619-74b0-a5a7-f83ce8df19e3
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: User reviewed medium-value item and chose promote on 2026-03-28.
- Reuse guidance: While implementing Windows Startup monitoring for wechat-channel-agents, writing watcher status under LOCALAPPDATA caused access-denied failures during Codex-side verification because the workspace-write sandbox cannot write there. For workspace-managed launchers that need to be verified from Codex, keep status files and logs under a project-local runtime directory such as wechat-channel-agents/.codex-runtime/autostart instead of external profile folders.

### [LRN-20260327-001] When restoring inaccessible local Codex skills, republish them into the user .agents skill root instead of relying on disabled .codex copies.
- Source thread: 019d2fc6-f619-74b0-a5a7-f83ce8df19e3
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: User reviewed medium-value item and chose promote on 2026-03-28.
- Reuse guidance: A previous skills dedup pass left academic-writing-style, ai-review-skills, find-skills, research-paper-writing, self-improving-agent, and workspace-knowledge-router inaccessible because both C:\Users\55451\.codex\skills\<name> and the program install root only contained SKILL.disabled.*.md files. Restoring accessibility by copying the full skill directories into C:\Users\55451\.agents\skills\<name> and materializing SKILL.md there avoids delete operations, preserves the disabled originals for audit, and places the active copy in the user skill root that is safer to manage than the program install tree.

### [LRN-20260327-003] Use C:\Users\55451\.agents\skills as the canonical skill root; do not rely on C:\Users\55451\.codex\skills for future skill integration.
- Source thread: 019d2fc6-f619-74b0-a5a7-f83ce8df19e3
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: User reviewed medium-value item and chose promote on 2026-03-28.
- Reuse guidance: User clarified on 2026-03-27 that .codex\skills is deprecated in this environment. Future self-improving merge work and router integration should target the new skills folder under ~/.agents/skills, with legacy .codex references treated as compatibility-only or migrated away.

### [LRN-20260327-006] Knowledge reads must be type-isolated by thread type; do not read across knowledge partitions.
- Source thread: 019d2fc6-f619-74b0-a5a7-f83ce8df19e3
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: User reviewed medium-value item and chose promote on 2026-03-28.
- Reuse guidance: User corrected the design on 2026-03-27. Knowledge retrieval must follow the current thread type and stay within that knowledge partition. Cross-partition reads are not allowed, even if content appears similar.

### [LRN-20260327-015] Use New-ScheduledTaskTrigger repetition parameters instead of New-ScheduledTaskRepetitionSettings on this Windows machine.
- Source thread: 019d2e62-dc3e-79f3-983c-5570682cc28c
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: User reviewed medium-value item and chose promote on 2026-03-28.
- Reuse guidance: While registering Codex store update tasks on 2026-03-27, the installer failed because New-ScheduledTaskRepetitionSettings was unavailable even though the ScheduledTasks module exposed New-ScheduledTaskTrigger with RepetitionInterval and RepetitionDuration parameters. The compatible fix was to build the repeating watchdog trigger directly with New-ScheduledTaskTrigger -Once -At <time> -RepetitionInterval <timespan> -RepetitionDuration <timespan> and then re-run the real task registration successfully.
### [LRN-20260328-001] Codex Store precheck can fail before detection when a protected Clash PID cannot be stopped; use the codex-store-update runtime root explicitly.
- Source thread: 019d2ea5-11be-7b51-ac11-ce91b77f9e25
- Source workspace: C:\Users\55451\OneDrive\scrips
- Source type: Learning
- Promotion reason: medium priority; generalizable learning category; broad reuse language
- Reuse guidance: Automation run 2026-03-28 00:04 CST. README points runtime to codex-store-update\\.codex-runtime\\codex-store-update, but Common.psm1 computes the workspace-root runtime unless CODEX_STORE_UPDATE_RUNTIME_ROOT is overridden. Using the requested runtime root, Invoke-CodexStorePrecheck.ps1 entered failed_preclose because Stop-Process on Clash for Windows PID 30008 returned access denied. A bounded repair attempt with Stop-Process -Force also failed with access denied. Codex stayed running and no post-close runner/update work executed.

<!-- knowledge:auto:end -->
