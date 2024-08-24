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
    printf '\e[1;34m'
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
set -x XCURSOR_PATH "~/.icons"
set -x XCURSOR_THEME "Hackneyed-24px"
end
