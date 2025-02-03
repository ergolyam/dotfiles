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

    # Проверка на git репозиторий и получение текущей ветки
    set -l git_branch ""
    if git rev-parse --abbrev-ref HEAD > /dev/null 2>&1
        set git_branch (git rev-parse --abbrev-ref HEAD)
    end

    if test -n "$git_branch"
        echo -n '['
        printf '\e[1;33m'
        echo -n "$git_branch"
        printf '\e[0m'
        echo -n ']'
    end

    # Проверка на активный venv
    if test -n "$VIRTUAL_ENV"
        echo -n '['
        printf '\e[1;94m'
        echo -n (basename "$VIRTUAL_ENV")
        printf '\e[0m'
        echo -n ']'
    end

    # Время
    echo -n (printf '\e[90m')'('
    echo -n (date +"%H:%M:%S")
    echo -n ')'(printf '\e[0m')

    if set -q __last_cmd_duration_ms
        if test $__last_cmd_duration_ms -ge 1000
            # Вычисление времени в секундах с двумя знаками после запятой
            set -l duration_sec (math "$__last_cmd_duration_ms / 1000.0")
            echo -n '['
            printf '\e[1;35m'
            printf '%.2fs' $duration_sec
            printf '\e[0m'
            echo -n ']'
        end
    end

    # Переход на новую строку
    echo
    echo -n '╰$ '
end

if test -n "$container"
    alias vi="/usr/bin/nvim"
else
    function vi
        toolbox run -c arch -- /usr/bin/nvim $argv
    end

    function lazygit
        toolbox run -c arch -- /usr/bin/lazygit $argv
    end

    function feh
        toolbox run -c arch -- /usr/bin/feh $argv
    end

    function trans
        toolbox run -c arch -- /usr/bin/trans $argv
    end
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

set -g VIRTUAL_ENV_DISABLE_PROMPT 1

# Инициализация переменной для хранения длительности команды
set -g __last_cmd_duration_ms 0

# Функция, вызываемая перед выполнением команды
function __preexec --on-event fish_preexec
    set -g __cmd_start_time (date +%s%N)
end

# Функция, вызываемая после выполнения команды
function __postexec --on-event fish_postexec
    set -l end_time (date +%s%N)
    set -l duration_ns (math "$end_time - $__cmd_start_time")
    set -g __last_cmd_duration_ms (math "($duration_ns) / 1000000")
end
end
