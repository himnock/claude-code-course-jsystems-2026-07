# Publish course slide decks to the DevPowers site repo.
# Junctions/symlinks do not work across two git repos (git tracks the link,
# not content) - this explicit copy is the sync mechanism. Run after any
# deck change, then review + commit in the DevPowers repo.
# Usage: pwsh scripts/publish-slides.ps1

$src = Split-Path $PSScriptRoot -Parent
$dst = "C:\Users\BiuroEdukey\DEV\Projects\DevPowers\szkolenia\claude-code-jsystems"

New-Item -ItemType Directory -Force -Path $dst | Out-Null
$copied = @()
foreach ($n in 1..3) {
    $from = Join-Path $src "slides\day-$n\index.html"
    if (Test-Path $from) {
        $to = Join-Path $dst "Prezentacja_Dzien$n.html"
        Copy-Item $from $to -Force
        $copied += "Prezentacja_Dzien$n.html"
    }
}
Write-Host "Copied to ${dst}: $($copied -join ', ')"
Write-Host "NEXT: cd to the DevPowers repo, review the diff, commit. Ask Lucas before pushing (production site)."
