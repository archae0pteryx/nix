#!/usr/bin/env bash
# Tailscale Exit Node Checker
# Checks if current exit node is optimal and switches if not
# Designed for Mullvad exit nodes via Tailscale
#
# Usage: Run as cron job, e.g.:
#   */30 * * * * /path/to/tailscale-exit-node-check.sh >> /var/log/tailscale-exit-node.log 2>&1

set -euo pipefail

LOG_PREFIX="[$(date '+%Y-%m-%d %H:%M:%S')]"

log() {
    echo "$LOG_PREFIX $1"
}

# Check if tailscale is running
if ! tailscale status &>/dev/null; then
    log "ERROR: Tailscale is not running"
    exit 1
fi

# Get current exit node
CURRENT_EXIT=$(tailscale status --json | jq -r '.ExitNodeStatus.ID // empty')
CURRENT_EXIT_NAME=""

if [[ -n "$CURRENT_EXIT" ]]; then
    CURRENT_EXIT_NAME=$(tailscale status --json | jq -r --arg id "$CURRENT_EXIT" '.Peer[$id].HostName // "unknown"')
    log "Current exit node: $CURRENT_EXIT_NAME ($CURRENT_EXIT)"
else
    log "No exit node currently configured"
fi

# Get suggested exit node
SUGGEST_OUTPUT=$(tailscale exit-node suggest 2>&1) || true

# Parse the suggested exit node ID from output
# Format: "Suggested exit node: us-nyc-wg-001.mullvad.ts.net (ID: xxxxxx)"
SUGGESTED_ID=$(echo "$SUGGEST_OUTPUT" | grep -oP '(?<=\(ID: )[^)]+' || echo "")

if [[ -z "$SUGGESTED_ID" ]]; then
    # Alternative parsing if format is different
    SUGGESTED_ID=$(echo "$SUGGEST_OUTPUT" | grep -oP 'exit-node=\K[^\s]+' || echo "")
fi

if [[ -z "$SUGGESTED_ID" ]]; then
    log "Could not determine suggested exit node from: $SUGGEST_OUTPUT"
    exit 1
fi

SUGGESTED_NAME=$(echo "$SUGGEST_OUTPUT" | grep -oP 'Suggested exit node: \K[^\s]+' || echo "$SUGGESTED_ID")
log "Suggested exit node: $SUGGESTED_NAME ($SUGGESTED_ID)"

# Compare and update if different
if [[ "$CURRENT_EXIT" == "$SUGGESTED_ID" ]]; then
    log "Already using optimal exit node, no change needed"
    exit 0
fi

log "Switching to suggested exit node..."
if sudo tailscale set --exit-node="$SUGGESTED_ID"; then
    log "Successfully switched to $SUGGESTED_NAME"

    # Verify the switch
    sleep 2
    NEW_EXIT=$(tailscale status --json | jq -r '.ExitNodeStatus.ID // empty')
    if [[ "$NEW_EXIT" == "$SUGGESTED_ID" ]]; then
        log "Verified: Now using $SUGGESTED_NAME"
    else
        log "WARNING: Switch may not have completed successfully"
    fi
else
    log "ERROR: Failed to switch exit node"
    exit 1
fi
