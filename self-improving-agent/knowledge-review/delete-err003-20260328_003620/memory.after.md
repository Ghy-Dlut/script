# Knowledge Review Memory

Use this file only as lightweight automation state. The source of truth is always the current knowledge files.

## Cursor
- current_bucket: medium
- high_index: 0
- medium_index: 0

## Reviewed Entries
- Store reviewed state by `review_key`
- Also store a short content hash beside each key
- If the source entry disappears, remove it from memory
- If the content hash changes, treat the entry as unreviewed again

## Decision Rules
- High-value entries allow only: `keep`, `delete`
- Medium-value entries allow only: `promote`, `keep`, `delete`
- Preferred reply key is the stable `review_key`:
  - high-value: `<scope>/<entry_id>`
  - medium-value: `review-queue/<entry_id>`
- A bare decision may only be accepted when exactly one item is visible in the current turn
- A user reply mapping `review_key` values to allowed decisions is sufficient authorization to stage changes immediately
- Staged decisions must be applied automatically after the last unreviewed item is judged

## Reviewed State
- review-queue/ERR-20260328-003 | decision=delete | content_hash=25EE53454D08 | reviewed_at=2026-03-28T00:36:20+08:00
- review-queue/LRN-20260327-007 | decision=promote | content_hash=0FA975A88100 | reviewed_at=2026-03-27T22:52:33+08:00
- programming/LRN-20260327-007 | decision=promoted-from-medium | content_hash=35CF2687E61C | reviewed_at=2026-03-27T22:52:33+08:00
- review-queue/LRN-20260327-010 | decision=delete | content_hash=85B9F97880D8 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-011 | decision=delete | content_hash=7D1C84B52FFC | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-012 | decision=delete | content_hash=212448991274 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260311-001 | decision=delete | content_hash=3B329A7013AA | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260313-002 | decision=delete | content_hash=2C9977F8343B | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260314-004 | decision=delete | content_hash=8C9954C7855B | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260323-002 | decision=delete | content_hash=0B3BA74A3951 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260326-001 | decision=delete | content_hash=C1301C3EB170 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260326-002 | decision=delete | content_hash=A4B5AD6BE2DF | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-002 | decision=delete | content_hash=D8ADEAE5D33D | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-005 | decision=delete | content_hash=C46FF42B8281 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-017 | decision=delete | content_hash=B4F20DF813A8 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260323-001 | decision=promote | content_hash=60179414B364 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260323-001 | decision=promoted-from-medium | content_hash=17CD1AB0AD49 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-001 | decision=promote | content_hash=75854E4C8AA2 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-001 | decision=promoted-from-medium | content_hash=A1006BEA3998 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-003 | decision=promote | content_hash=9775E9E17EB9 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-003 | decision=promoted-from-medium | content_hash=1AFB9E0F25E0 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-006 | decision=promote | content_hash=9AB9B4E37DB0 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-006 | decision=promoted-from-medium | content_hash=00B8CAE10D93 | reviewed_at=2026-03-28T00:18:20+08:00
- review-queue/LRN-20260327-015 | decision=promote | content_hash=1695989CD6A3 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-015 | decision=promoted-from-medium | content_hash=B3742884479F | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-008 | decision=keep | content_hash=E4FAF0FD17E1 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260312-001 | decision=keep | content_hash=E95563F868CC | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260323-003 | decision=keep | content_hash=149A184F5FC6 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260325-002 | decision=keep | content_hash=339A9AB6731D | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-004 | decision=keep | content_hash=47DA087A83BF | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-018 | decision=keep | content_hash=9C620C66E0EA | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-009 | decision=delete | content_hash=1505219BB498 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260312-002 | decision=delete | content_hash=77A8EFFD195D | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260325-001 | decision=delete | content_hash=EEE446850DD8 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260327-016 | decision=delete | content_hash=9D1B8C28C3C1 | reviewed_at=2026-03-28T00:18:20+08:00
- programming/LRN-20260328-001 | decision=delete | content_hash=E97FA7D90CCC | reviewed_at=2026-03-28T00:18:20+08:00

## Staged Decisions
- none
