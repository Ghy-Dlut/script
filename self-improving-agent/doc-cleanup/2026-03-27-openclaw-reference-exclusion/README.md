## 2026-03-27 OpenClaw Reference Exclusion

This snapshot captures the documentation change that makes the current
Windows Codex flow explicitly avoid OpenClaw reference materials unless the
user asks for OpenClaw-specific help.

Included updates:
- `AGENTS.md` now states that OpenClaw reference documents should not be read in this environment unless the user explicitly asks.
- `self-improving-agent/assets/AGENTS-CODEX.md` carries the same exclusion so generated workspace guidance stays aligned.
- `self-improving-agent/SKILL.md` now excludes `references/openclaw-integration.md`, `references/hooks-setup.md`, and `hooks/openclaw/` from the default Windows Codex flow.
- `DocsCleanup.Tests.ps1` now verifies the exclusion.

Local backup for this cleanup round:
- `C:\Users\55451\OneDrive\scrips\skill_backups\router_openclaw_exclusion_20260327_212447`

Archive details:
- Local zip: `C:\Users\55451\OneDrive\scrips\outputs\self-improving-agent-openclaw-exclusion-20260327.zip`
- SHA256: `01519C2BC97AF9785C3AC8D00047624EC7EE276796B64F0E36AE7374B3D80193`
