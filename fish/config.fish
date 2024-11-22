if status is-interactive
function fish_prompt
    # Верхняя часть prompt
    echo -n '╭['

    # Имя пользователя
    printf '\e[1;92m'
    echo -n $USER
    printf '\e[0m'
    echo -n '@'

    # Имя хоста
    if test -n "$container"
        printf '\e[1;34m'
    else if test -n "$SSH_CONNECTION"
        printf '\e[1;38;5;214m'
    else
        printf '\e[1;31m'
    end
    echo -n $hostname
    printf '\e[0m'
    echo -n ']'

    # Текущая директория
    echo -n '['
    printf '\e[1;36m'
    echo -n $PWD
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
set -g -x fish_greeting ""
set -g -x TERM xterm-256color
set -g -x XCURSOR_PATH "~/.icons"
set -g -x XCURSOR_THEME "Hackneyed-24px"
set -g -x ANDROID_HOME ~/.local/share/android-sdk
set -Ua fish_user_paths ~/.local/bin
set -Ua fish_user_paths $ANDROID_HOME/cmdline-tools/bin
set -Ua fish_user_paths $ANDROID_HOME/platform-tools 
set -Ua fish_user_paths $ANDROID_HOME/build-tools/33.0.0
end
