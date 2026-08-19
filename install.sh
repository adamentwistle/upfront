#!/usr/bin/env bash
# Install the Upfront output style into your Claude Code config directory.
#
# Usage:
#   ./install.sh                    install into the active config directory
#   CLAUDE_DIR=/path ./install.sh   install somewhere specific
#
# The config directory is $CLAUDE_CONFIG_DIR when set, otherwise $HOME/.claude.
# If you run more than one Claude profile, install into each one you want the
# style available in.
#
# Nothing is activated. Pick the style with /config -> Output style.
set -euo pipefail

CLAUDE_DIR="${CLAUDE_DIR:-${CLAUDE_CONFIG_DIR:-$HOME/.claude}}"
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SELF_DIR/output-styles/upfront.md"

[ -f "$SRC" ] || { echo "run this from a complete checkout: $SRC is missing" >&2; exit 1; }
[ -d "$CLAUDE_DIR" ] || { echo "no Claude config directory at $CLAUDE_DIR. Set CLAUDE_DIR to the right one." >&2; exit 1; }

mkdir -p "$CLAUDE_DIR/output-styles"
cp "$SRC" "$CLAUDE_DIR/output-styles/upfront.md"

echo "installed: $CLAUDE_DIR/output-styles/upfront.md"
echo
echo "Activate it: run /config, choose Output style, pick Upfront."
echo "It takes effect after /clear or the next session."
echo
echo "Not in the list? You installed into a config directory this session isn't"
echo "using. Check with: echo \"\${CLAUDE_CONFIG_DIR:-\$HOME/.claude}\""
