param(
    [string]$ReviewQueuePath = 'C:\Users\55451\.agents\knowledge-base\review-queue\MEDIUM_VALUE_REVIEW.md',
    [string]$ProgrammingKnowledgePath = 'C:\Users\55451\.agents\knowledge-base\programming\KNOWLEDGE.md',
    [string]$MemoryPath = 'C:\Users\55451\.codex\automations\knowledge-review-weekly\memory.md',
    [string]$ReferenceReviewQueuePath = 'C:\Users\55451\OneDrive\scrips\skill_backups\knowledge_review_apply_20260328_001820\MEDIUM_VALUE_REVIEW.before.md',
    [string]$ReferenceProgrammingKnowledgePath = 'C:\Users\55451\OneDrive\scrips\skill_backups\knowledge_review_apply_20260328_001820\PROGRAMMING_KNOWLEDGE.before.md'
)

$ErrorActionPreference = 'Stop'

function Get-ShortHash {
    param([Parameter(Mandatory = $true)][string]$Text)

    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
        $hash = $sha.ComputeHash($bytes)
        return ([System.BitConverter]::ToString($hash)).Replace('-', '').Substring(0, 12)
    } finally {
        $sha.Dispose()
    }
}

function Get-EntryBlockMap {
    param(
        [Parameter(Mandatory = $true)][string]$Content,
        [Parameter(Mandatory = $true)][string]$EndMarker
    )

    $map = @{}
    $pattern = '(?ms)^### \[(?<id>[^\]]+)\].*?(?=^### \[|^' + [regex]::Escape($EndMarker) + ')'
    foreach ($match in [regex]::Matches($Content, $pattern)) {
        $map[$match.Groups['id'].Value] = $match.Value.TrimEnd()
    }
    return $map
}

function Remove-EntryBlock {
    param(
        [Parameter(Mandatory = $true)][string]$Content,
        [Parameter(Mandatory = $true)][string]$EntryId,
        [Parameter(Mandatory = $true)][string]$EndMarker
    )

    $pattern = '(?ms)^### \[' + [regex]::Escape($EntryId) + '\].*?(?=^### \[|^' + [regex]::Escape($EndMarker) + ')'
    return [regex]::Replace($Content, $pattern, '')
}

function Normalize-MarkdownSpacing {
    param([Parameter(Mandatory = $true)][string]$Content)

    $normalized = $Content -replace "(`r`n){3,}", "`r`n`r`n"
    $normalized = $normalized -replace "`r`n`r`n<!--", "`r`n<!--"
    return $normalized
}

function Insert-BeforeMarker {
    param(
        [Parameter(Mandatory = $true)][string]$Content,
        [Parameter(Mandatory = $true)][string]$EndMarker,
        [Parameter(Mandatory = $true)][string]$Block
    )

    if (-not $Content.Contains($EndMarker)) {
        throw "End marker not found: $EndMarker"
    }

    return $Content.Replace($EndMarker, ($Block.TrimEnd() + "`r`n`r`n" + $EndMarker))
}

function Build-PromotedKnowledgeBlock {
    param(
        [Parameter(Mandatory = $true)][string]$EntryId,
        [Parameter(Mandatory = $true)][string]$Title,
        [Parameter(Mandatory = $true)][string]$SourceThread,
        [Parameter(Mandatory = $true)][string]$SourceWorkspace,
        [Parameter(Mandatory = $true)][string]$ReuseGuidance
    )

@"
### [$EntryId] $Title
- Source thread: $SourceThread
- Source workspace: $SourceWorkspace
- Source type: Learning
- Promotion reason: User reviewed medium-value item and chose promote on 2026-03-28.
- Reuse guidance: $ReuseGuidance
"@
}

$reviewQueueBefore = Get-Content -LiteralPath $ReviewQueuePath -Raw -Encoding UTF8
$programmingBefore = Get-Content -LiteralPath $ProgrammingKnowledgePath -Raw -Encoding UTF8
$memoryBefore = Get-Content -LiteralPath $MemoryPath -Raw -Encoding UTF8
$referenceReviewQueue = Get-Content -LiteralPath $ReferenceReviewQueuePath -Raw -Encoding UTF8
$referenceProgrammingKnowledge = Get-Content -LiteralPath $ReferenceProgrammingKnowledgePath -Raw -Encoding UTF8

$reviewQueueBlocks = Get-EntryBlockMap -Content $referenceReviewQueue -EndMarker '<!-- review:queue:end -->'
$programmingBlocksBefore = Get-EntryBlockMap -Content $referenceProgrammingKnowledge -EndMarker '<!-- knowledge:auto:end -->'

$mediumDeletes = @(
    'LRN-20260327-010',
    'LRN-20260327-011',
    'LRN-20260327-012',
    'LRN-20260311-001',
    'LRN-20260313-002',
    'LRN-20260314-004',
    'LRN-20260323-002',
    'LRN-20260326-001',
    'LRN-20260326-002',
    'LRN-20260327-002',
    'LRN-20260327-005',
    'LRN-20260327-017'
)

$mediumPromotes = @(
    [PSCustomObject]@{
        Id = 'LRN-20260323-001'
        Title = 'Use project-local runtime state for Codex-triggered startup scripts in this workspace'
        SourceThread = '019d2fc6-f619-74b0-a5a7-f83ce8df19e3'
        SourceWorkspace = 'C:\Users\55451\OneDrive\scrips'
        ReuseGuidance = 'While implementing Windows Startup monitoring for wechat-channel-agents, writing watcher status under LOCALAPPDATA caused access-denied failures during Codex-side verification because the workspace-write sandbox cannot write there. For workspace-managed launchers that need to be verified from Codex, keep status files and logs under a project-local runtime directory such as wechat-channel-agents/.codex-runtime/autostart instead of external profile folders.'
    }
    [PSCustomObject]@{
        Id = 'LRN-20260327-001'
        Title = 'When restoring inaccessible local Codex skills, republish them into the user .agents skill root instead of relying on disabled .codex copies.'
        SourceThread = '019d2fc6-f619-74b0-a5a7-f83ce8df19e3'
        SourceWorkspace = 'C:\Users\55451\OneDrive\scrips'
        ReuseGuidance = 'A previous skills dedup pass left academic-writing-style, ai-review-skills, find-skills, research-paper-writing, self-improving-agent, and workspace-knowledge-router inaccessible because both C:\Users\55451\.codex\skills\<name> and the program install root only contained SKILL.disabled.*.md files. Restoring accessibility by copying the full skill directories into C:\Users\55451\.agents\skills\<name> and materializing SKILL.md there avoids delete operations, preserves the disabled originals for audit, and places the active copy in the user skill root that is safer to manage than the program install tree.'
    }
    [PSCustomObject]@{
        Id = 'LRN-20260327-003'
        Title = 'Use C:\Users\55451\.agents\skills as the canonical skill root; do not rely on C:\Users\55451\.codex\skills for future skill integration.'
        SourceThread = '019d2fc6-f619-74b0-a5a7-f83ce8df19e3'
        SourceWorkspace = 'C:\Users\55451\OneDrive\scrips'
        ReuseGuidance = 'User clarified on 2026-03-27 that .codex\skills is deprecated in this environment. Future self-improving merge work and router integration should target the new skills folder under ~/.agents/skills, with legacy .codex references treated as compatibility-only or migrated away.'
    }
    [PSCustomObject]@{
        Id = 'LRN-20260327-006'
        Title = 'Knowledge reads must be type-isolated by thread type; do not read across knowledge partitions.'
        SourceThread = '019d2fc6-f619-74b0-a5a7-f83ce8df19e3'
        SourceWorkspace = 'C:\Users\55451\OneDrive\scrips'
        ReuseGuidance = 'User corrected the design on 2026-03-27. Knowledge retrieval must follow the current thread type and stay within that knowledge partition. Cross-partition reads are not allowed, even if content appears similar.'
    }
    [PSCustomObject]@{
        Id = 'LRN-20260327-015'
        Title = 'Use New-ScheduledTaskTrigger repetition parameters instead of New-ScheduledTaskRepetitionSettings on this Windows machine.'
        SourceThread = '019d2e62-dc3e-79f3-983c-5570682cc28c'
        SourceWorkspace = 'C:\Users\55451\OneDrive\scrips'
        ReuseGuidance = 'While registering Codex store update tasks on 2026-03-27, the installer failed because New-ScheduledTaskRepetitionSettings was unavailable even though the ScheduledTasks module exposed New-ScheduledTaskTrigger with RepetitionInterval and RepetitionDuration parameters. The compatible fix was to build the repeating watchdog trigger directly with New-ScheduledTaskTrigger -Once -At <time> -RepetitionInterval <timespan> -RepetitionDuration <timespan> and then re-run the real task registration successfully.'
    }
)

$queueRemovals = @($mediumDeletes + @($mediumPromotes | ForEach-Object { $_.Id }) + 'LRN-20260327-007') | Select-Object -Unique

$highDeletes = @(
    'LRN-20260327-009',
    'LRN-20260312-002',
    'LRN-20260325-001',
    'LRN-20260327-016',
    'LRN-20260328-001'
)

$highKeeps = @(
    'LRN-20260327-008',
    'LRN-20260312-001',
    'LRN-20260323-003',
    'LRN-20260325-002',
    'LRN-20260327-004',
    'LRN-20260327-018'
)

$reviewedAt = '2026-03-28T00:18:20+08:00'

$reviewQueueAfter = $reviewQueueBefore
foreach ($id in $queueRemovals) {
    $reviewQueueAfter = Remove-EntryBlock -Content $reviewQueueAfter -EntryId $id -EndMarker '<!-- review:queue:end -->'
}
$reviewQueueAfter = Normalize-MarkdownSpacing -Content $reviewQueueAfter

$programmingAfter = $programmingBefore
foreach ($id in $highDeletes) {
    $programmingAfter = Remove-EntryBlock -Content $programmingAfter -EntryId $id -EndMarker '<!-- knowledge:auto:end -->'
}

$promotedBlocks = @{}
foreach ($item in $mediumPromotes) {
    $block = Build-PromotedKnowledgeBlock -EntryId $item.Id -Title $item.Title -SourceThread $item.SourceThread -SourceWorkspace $item.SourceWorkspace -ReuseGuidance $item.ReuseGuidance
    $promotedBlocks[$item.Id] = $block
    $programmingAfter = Remove-EntryBlock -Content $programmingAfter -EntryId $item.Id -EndMarker '<!-- knowledge:auto:end -->'
    $programmingAfter = Insert-BeforeMarker -Content $programmingAfter -EndMarker '<!-- knowledge:auto:end -->' -Block $block
}
$programmingAfter = Normalize-MarkdownSpacing -Content $programmingAfter

$reviewedLines = [ordered]@{}
$reviewedLines['review-queue/LRN-20260327-007'] = '- review-queue/LRN-20260327-007 | decision=promote | content_hash=0FA975A88100 | reviewed_at=2026-03-27T22:52:33+08:00'
$reviewedLines['programming/LRN-20260327-007'] = '- programming/LRN-20260327-007 | decision=promoted-from-medium | content_hash=35CF2687E61C | reviewed_at=2026-03-27T22:52:33+08:00'

foreach ($id in $mediumDeletes) {
    $block = $reviewQueueBlocks[$id]
    if ($block) {
        $reviewedLines["review-queue/$id"] = "- review-queue/$id | decision=delete | content_hash=$(Get-ShortHash -Text $block) | reviewed_at=$reviewedAt"
    }
}

foreach ($item in $mediumPromotes) {
    $queueBlock = $reviewQueueBlocks[$item.Id]
    if ($queueBlock) {
        $reviewedLines["review-queue/$($item.Id)"] = "- review-queue/$($item.Id) | decision=promote | content_hash=$(Get-ShortHash -Text $queueBlock) | reviewed_at=$reviewedAt"
    }
    $reviewedLines["programming/$($item.Id)"] = "- programming/$($item.Id) | decision=promoted-from-medium | content_hash=$(Get-ShortHash -Text $promotedBlocks[$item.Id]) | reviewed_at=$reviewedAt"
}

foreach ($id in $highKeeps) {
    $block = $programmingBlocksBefore[$id]
    if ($block) {
        $reviewedLines["programming/$id"] = "- programming/$id | decision=keep | content_hash=$(Get-ShortHash -Text $block) | reviewed_at=$reviewedAt"
    }
}

foreach ($id in $highDeletes) {
    $block = $programmingBlocksBefore[$id]
    if ($block) {
        $reviewedLines["programming/$id"] = "- programming/$id | decision=delete | content_hash=$(Get-ShortHash -Text $block) | reviewed_at=$reviewedAt"
    }
}

$memoryLines = @(
    '# Knowledge Review Memory',
    '',
    'Use this file only as lightweight automation state. The source of truth is always the current knowledge files.',
    '',
    '## Cursor',
    '- current_bucket: medium',
    '- high_index: 0',
    '- medium_index: 0',
    '',
    '## Reviewed Entries',
    '- Store reviewed state by `review_key`',
    '- Also store a short content hash beside each key',
    '- If the source entry disappears, remove it from memory',
    '- If the content hash changes, treat the entry as unreviewed again',
    '',
    '## Decision Rules',
    '- High-value entries allow only: `keep`, `delete`',
    '- Medium-value entries allow only: `promote`, `keep`, `delete`',
    '- Preferred reply key is the stable `review_key`:',
    '  - high-value: `<scope>/<entry_id>`',
    '  - medium-value: `review-queue/<entry_id>`',
    '- A bare decision may only be accepted when exactly one item is visible in the current turn',
    '- A user reply mapping `review_key` values to allowed decisions is sufficient authorization to stage changes immediately',
    '- Staged decisions must be applied automatically after the last unreviewed item is judged',
    '',
    '## Reviewed State'
)

$memoryLines += @($reviewedLines.Values)
$memoryLines += @(
    '',
    '## Staged Decisions',
    '- none',
    ''
)

Set-Content -LiteralPath $ReviewQueuePath -Value $reviewQueueAfter -Encoding UTF8
Set-Content -LiteralPath $ProgrammingKnowledgePath -Value $programmingAfter -Encoding UTF8
Set-Content -LiteralPath $MemoryPath -Value ($memoryLines -join "`r`n") -Encoding UTF8

[PSCustomObject]@{
    review_queue_removed = $queueRemovals.Count
    promoted_from_medium = $mediumPromotes.Count
    deleted_high_value = $highDeletes.Count
    kept_high_value = $highKeeps.Count
    queue_is_empty = (-not ($reviewQueueAfter -match '(?m)^### \[LRN-'))
}
