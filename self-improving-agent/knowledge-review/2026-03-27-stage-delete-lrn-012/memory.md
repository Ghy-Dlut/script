# Knowledge Review Memory

Use this file only as lightweight automation state. The source of truth is always the current knowledge files.

## Cursor
- current_bucket: medium
- high_index: 0
- medium_index: 4

## Reviewed Entries
- Store reviewed state by `review_key`
- Also store a short content hash beside each key
- If the source entry disappears, remove it from memory
- If the content hash changes, treat the entry as unreviewed again

## Decision Rules
- High-value entries allow only: `保留`, `删除`
- Medium-value entries allow only: `提升`, `保留`, `删除`
- Preferred reply key is the stable `review_key`:
  - high-value: `<scope>/<entry_id>`
  - medium-value: `review-queue/<entry_id>`
- A bare decision may only be accepted when exactly one item is visible in the current turn
- A user reply mapping `review_key` values to allowed decisions is sufficient authorization to stage changes immediately
- Staged decisions must be applied automatically after the last unreviewed item is judged

## Reviewed State
- review-queue/LRN-20260327-007 | decision=提升 | content_hash=0FA975A88100 | reviewed_at=2026-03-27T22:52:33+08:00
- programming/LRN-20260327-007 | decision=promoted-from-medium | content_hash=35CF2687E61C | reviewed_at=2026-03-27T22:52:33+08:00

## Staged Decisions
- review-queue/LRN-20260327-010 | decision=删除 | content_hash=784CA4355CDD | staged_at=2026-03-27T23:00:38+08:00
- review-queue/LRN-20260327-011 | decision=删除 | content_hash=72917241A221 | staged_at=2026-03-27T23:06:23+08:00
- review-queue/LRN-20260327-012 | decision=删除 | content_hash=67F03F66589E | staged_at=2026-03-27T23:09:51+08:00
