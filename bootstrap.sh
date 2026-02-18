#!/bin/bash
set -euo pipefail
TEMPLATE_REPO="${TEMPLATE_REPO:-gh:your-org/platform-scaffold}"
GITHUB_URL="${TEMPLATE_REPO/gh:/https://github.com/}"
COPIER_VENV=".copier-venv"

# --- Review prerequisites ---
echo ""
echo "Prerequisites: $GITHUB_URL/blob/main/PREREQUISITES.md"
echo "Review the link above before continuing."
read -rp "Press Enter to continue (Ctrl+C to abort)..."
echo ""

# --- Check prerequisites ---
if ! command -v python3 &>/dev/null; then
    echo "Error: Python 3 is required but not found." >&2
    exit 1
fi
py_minor=$(python3 -c 'import sys; print(sys.version_info.minor)')
if [ "$py_minor" -lt 12 ]; then
    echo "Error: Python 3.12+ required, found 3.$py_minor" >&2
    exit 1
fi
if ! command -v git &>/dev/null; then
    echo "Error: Git is required but not found." >&2
    exit 1
fi

# --- Install copier in a temporary venv ---
echo "Setting up copier..."
python3 -m venv "$COPIER_VENV"
"$COPIER_VENV/bin/pip" install --quiet copier

# --- Apply template ---
echo "Applying engineering standards..."
"$COPIER_VENV/bin/copier" copy "$TEMPLATE_REPO" .

# --- Clean up temporary venv ---
rm -rf "$COPIER_VENV"

echo "Done! Run 'source .venv/bin/activate' to get started."
