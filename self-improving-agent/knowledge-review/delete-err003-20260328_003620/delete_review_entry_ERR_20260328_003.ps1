param(
    [string]$ReviewQueuePath = 'C:\Users\55451\.agents\knowledge-base\review-queue\MEDIUM_VALUE_REVIEW.md',
    [string]$MemoryPath = 'C:\Users\55451\.codex\automations\knowledge-review-weekly\memory.md'
)

$ErrorActionPreference = 'Stop'
$entryId = 'ERR-20260328-003'
$reviewKey = 'review-queue/ERR-20260328-003'
$reviewedAt = '2026-03-28T00:36:20+08:00'

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

$queueContent = Get-Content -LiteralPath $ReviewQueuePath -Raw -Encoding UTF8
$pattern = '(?ms)^### \[' + [regex]::Escape($entryId) + '\].*?(?=^### \[|^<!-- review:queue:end -->)'
$match = [regex]::Match($queueContent, $pattern)
if (-not $match.Success) {
    throw "Queue entry not found: $entryId"
}

$updatedQueue = [regex]::Replace($queueContent, $pattern, '')
$updatedQueue = $updatedQueue -replace "(`r`n){3,}", "`r`n`r`n"
$updatedQueue = $updatedQueue -replace "`r`n`r`n<!--", "`r`n<!--"
Set-Content -LiteralPath $ReviewQueuePath -Value $updatedQueue -Encoding UTF8

$memoryContent = Get-Content -LiteralPath $MemoryPath -Raw -Encoding UTF8
$reviewLine = "- $reviewKey | decision=delete | content_hash=$(Get-ShortHash -Text $match.Value.TrimEnd()) | reviewed_at=$reviewedAt"
if ($memoryContent -notmatch [regex]::Escape($reviewLine)) {
    $memoryContent = $memoryContent -replace "(?ms)(## Reviewed State\r?\n)", ('$1' + $reviewLine + "`r`n")
    Set-Content -LiteralPath $MemoryPath -Value $memoryContent -Encoding UTF8
}

[PSCustomObject]@{
    entry_id = $entryId
    action = 'deleted'
    queue_has_pending_lrn = ($updatedQueue -match '(?m)^### \[LRN-')
}
