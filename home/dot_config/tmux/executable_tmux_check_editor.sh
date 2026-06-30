#!/usr/bin/env bash
editors='vi|vim|nvim|nano|less'

for tty in $(tmux list-panes -F "#{pane_tty}"); do
    if ps -t "$tty" -o comm= | grep -Eq "$editors"; then
        tmux confirm-before -p "Editor is open — close window? (y/n)" kill-window
        exit 0
    fi
done

tmux kill-window

