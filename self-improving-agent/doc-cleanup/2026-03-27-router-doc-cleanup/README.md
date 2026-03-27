## 2026-03-27 Router Doc Cleanup

This snapshot captures the documentation cleanup that aligned the installed
`self-improving-agent` and `workspace-knowledge-router` guidance with the
router-led architecture in the current Windows Codex environment.

Included updates:
- `AGENTS.md` now treats `workspace-knowledge-router` as the only start-of-task entrypoint.
- `self-improving-agent` AGENTS instructions now document direct startup/finalize calls as fallback-only behavior.
- Router-facing docs now state that global knowledge reads are isolated by thread type and must not cross knowledge partitions.
- The self-improving skill now marks the local `.agents` installation as the primary Windows Codex path and keeps OpenClaw guidance as legacy/optional.
- `DocsCleanup.Tests.ps1` verifies the router-first and type-isolated documentation rules.

Local backup for this cleanup round:
- `C:\Users\55451\OneDrive\scrips\skill_backups\router_merge_doc_cleanup_20260327_210749`

Archive details:
- Local zip: `C:\Users\55451\OneDrive\scrips\outputs\self-improving-agent-doc-cleanup-20260327-router-doc-cleanup.zip`
- SHA256: `75DCF25AE403AC7728FCD45219771BE837E48E2CC368496F6A82DCC2C9443A48`
