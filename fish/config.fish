set -g -x fish_greeting ""
set -g -x TERM xterm-256color
set -g -x XCURSOR_PATH "~/.icons"
set -g -x XCURSOR_THEME "Hackneyed-24px"
set -g -x ANDROID_HOME ~/.local/share/android-sdk
set -g -x ANDROID_SDK_ROOT $ANDROID_HOME
set -Ua fish_user_paths ~/.local/bin
set -Ua fish_user_paths $ANDROID_HOME/cmdline-tools/latest/bin
set -Ua fish_user_paths $ANDROID_HOME/platform-tools
set -g VIRTUAL_ENV_DISABLE_PROMPT 1
set -g __last_cmd_duration_ms 0
set -g fish_prompt_pwd_dir_length 0
bind \cl real_clear

if status --is-interactive; and set -q SUDO_USER; and test (id -u) -ne 0
    set -x XDG_RUNTIME_DIR "/run/user/$(id -u)"
    set -x DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus"
end
