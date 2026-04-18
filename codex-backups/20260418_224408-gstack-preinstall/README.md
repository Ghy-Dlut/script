# gstack preinstall backup

Timestamp: `20260418_224408`
Target: `garrytan/gstack@gstack`
SHA256 of reconstructed zip: `E1F731684A694ED059708B5DF8D02278E55AE5A63FACFD13C2E4936B61EAED37`

## Restore

1. Concatenate all `chunks/skills-preinstall.part*.txt` files in lexical order into one Base64 file.
2. Decode that Base64 content into `skills-preinstall.zip`.
3. Expand the zip and copy the extracted `.codex\skills` contents back to `C:\Users\hp\.codex\skills`.

PowerShell example:

```powershell
$dir = Join-Path $PWD 'chunks'
$b64 = (Get-ChildItem $dir 'skills-preinstall.part*.txt' | Sort-Object Name | Get-Content -Raw)
Set-Content -Path (Join-Path $PWD 'skills-preinstall.zip.base64.txt') -Value $b64 -Encoding ASCII
[IO.File]::WriteAllBytes((Join-Path $PWD 'skills-preinstall.zip'), [Convert]::FromBase64String($b64))
Expand-Archive -Path (Join-Path $PWD 'skills-preinstall.zip') -DestinationPath (Join-Path $PWD 'restored')
```
