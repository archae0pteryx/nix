# tmux auto-attach to the last session if it's not already attached
tmux_auto_attach() {
  # Ensure tmux is installed
  if ! command -v tmux &> /dev/null; then
    return
  fi

  # If already inside a tmux session, do nothing
  if [ -n "$TMUX" ]; then
    return
  fi

  # Check if there are any existing tmux sessions
  if tmux has-session 2>/dev/null; then
    # Get the last session name (most recently created)
    last_session=$(tmux ls -F '#{session_name}' | tail -n1)

    # Check if the last session is attached
    attached=$(tmux display-message -p -t "$last_session" "#{session_attached}")

    if [ "$attached" -eq 0 ]; then
      # If not attached, attach to the last session
      tmux attach-session -t "$last_session"
    else
      # If attached, create a new session with a default name
      tmux new-session -A -s "$(date +%s)"
    fi
  else
    # No existing sessions, create a new one
    tmux new-session
  fi
}

if [ "$1" = "--no-tmux" ] || [ "$TERM_PROGRAM" = "vscode" ]; then
  echo "Skipping tmux auto-attach..."
  exit 0
fi

tmux_auto_attach
