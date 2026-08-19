#!/usr/bin/env bash
# Install the Status First output style into ~/.claude/output-styles/.
#
# Usage:
#   ./install.sh              install into $HOME/.claude
#   CLAUDE_DIR=/path ./install.sh   install elsewhere
#
# Nothing is activated. Pick the style with /config -> Output style.
set -euo pipefail

CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SELF_DIR/output-styles/status-first.md"

[ -f "$SRC" ] || { echo "run this from a complete checkout: $SRC is missing" >&2; exit 1; }

mkdir -p "$CLAUDE_DIR/output-styles"
cp "$SRC" "$CLAUDE_DIR/output-styles/status-first.md"

echo "installed: $CLAUDE_DIR/output-styles/status-first.md"
echo
echo "Activate it: run /config, choose Output style, pick Status First."
echo "It takes effect after /clear or the next session."
