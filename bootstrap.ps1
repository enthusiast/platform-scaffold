$ErrorActionPreference = "Stop"
if (-not $env:TEMPLATE_REPO) { $env:TEMPLATE_REPO = "gh:your-org/platform-scaffold" }
$GitHubUrl = $env:TEMPLATE_REPO -replace "^gh:", "https://github.com/"
$CopierVenv = ".copier-venv"

# --- Review prerequisites ---
Write-Host ""
Write-Host "Prerequisites: $GitHubUrl/blob/main/PREREQUISITES.md"
Write-Host "Review the link above before continuing."
Read-Host "Press Enter to continue (Ctrl+C to abort)"
Write-Host ""

# --- Check prerequisites ---
if (-not (Get-Command python3 -ErrorAction SilentlyContinue)) {
    if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Error "Python 3 is required but not found."
        exit 1
    }
    Set-Alias -Name python3 -Value python
}
$pyMinor = python3 -c "import sys; print(sys.version_info.minor)"
if ([int]$pyMinor -lt 12) {
    Write-Error "Python 3.12+ required, found 3.$pyMinor"
    exit 1
}
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is required but not found."
    exit 1
}

# --- Install copier in a temporary venv ---
Write-Host "Setting up copier..."
python3 -m venv $CopierVenv
& "$CopierVenv\Scripts\pip" install --quiet copier

# --- Apply template ---
Write-Host "Applying engineering standards..."
& "$CopierVenv\Scripts\copier" copy $env:TEMPLATE_REPO .

# --- Clean up temporary venv ---
Remove-Item -Recurse -Force $CopierVenv

Write-Host "Done! Run '.\.venv\Scripts\Activate.ps1' to get started."
