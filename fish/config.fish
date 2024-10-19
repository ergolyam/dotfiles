if status is-interactive
function fish_prompt
    # Верхняя часть prompt
    echo -n '╭['

    # Имя пользователя
    printf '\e[1;92m'
    echo -n (whoami)
    printf '\e[0m'
    echo -n '@'

    # Имя хоста
    if test -n "$DISTROBOX_ENTER_PATH"
        printf '\e[1;34m'
    else if test -n "$SSH_CONNECTION"
        printf '\e[38;5;214m'
    else
        printf '\e[1;31m'
    end
    echo -n (hostname | cut -d . -f 1)
    printf '\e[0m'
    echo -n ']'

    # Текущая директория
    echo -n '['
    printf '\e[1;36m'
    echo -n (pwd)
    printf '\e[0m'
    echo -n ']'

    # Время
    echo -n (printf '\e[90m')'('
    echo -n (date +"%H:%M:%S")
    echo -n ')'(printf '\e[0m')

    # Переход на новую строку
    echo
    echo -n '╰$ '
end
alias ssh 'env TERM=xterm-256color ssh'
set -g -x fish_greeting ""
set -U fish_user_paths $fish_user_paths ~/.local/bin
set -x XCURSOR_PATH "~/.icons"
set -x XCURSOR_THEME "Hackneyed-24px"
set -x ANDROID_HOME ~/.local/share/android-sdk
set -x PATH $ANDROID_HOME/cmdline-tools/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/build-tools/33.0.0/ $PATH
end
