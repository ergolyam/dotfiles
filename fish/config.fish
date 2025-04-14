set -g -x fish_greeting ""
set -g -x TERM xterm-256color
set -g -x XCURSOR_PATH "~/.icons"
set -g -x XCURSOR_THEME "Hackneyed-24px"
set -g -x ANDROID_HOME ~/.local/share/android-sdk
set -Ua fish_user_paths ~/.local/bin
set -Ua fish_user_paths $ANDROID_HOME/cmdline-tools/bin
set -Ua fish_user_paths $ANDROID_HOME/platform-tools 
set -Ua fish_user_paths $ANDROID_HOME/build-tools/33.0.0
set -g VIRTUAL_ENV_DISABLE_PROMPT 1
set -g __last_cmd_duration_ms 0

