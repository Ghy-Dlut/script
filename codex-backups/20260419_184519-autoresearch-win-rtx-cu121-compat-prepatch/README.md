autoresearch-win-rtx cu121 compatibility prepatch backup

Timestamp: `20260419_184519`
Target: `C:\Users\hp\.codex\repos\autoresearch-win-rtx\pyproject.toml`

This backup captures the local repo state before applying a compatibility patch that downgrades the PyTorch CUDA runtime target for this machine.

Restore notes:
- Restore `pyproject.toml`, `uv.lock`, and `.python-version` from this folder if you want to revert the local compatibility patch.
- This backup only covers the isolated `autoresearch-win-rtx` repo.
