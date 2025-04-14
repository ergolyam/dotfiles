function fish_prompt
    echo -n '╭['
    printf '\e[1;92m'
    echo -n $USER
    printf '\e[0m'
    echo -n '@'

    if test -n "$container"
        printf '\e[1;34m'
    else if test -n "$SSH_CONNECTION"
        printf '\e[1;38;5;214m'
    else
        printf '\e[1;31m'
    end
    if test -n "$container_hostname"
      echo -n $container_hostname
    else
      echo -n $hostname
    end
    printf '\e[0m'
    echo -n ']'

    echo -n '['
    printf '\e[1;36m'
    echo -n (prompt_pwd)
    printf '\e[0m'
    echo -n ']'

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

    if test -n "$VIRTUAL_ENV"
        echo -n '['
        printf '\e[1;94m'
        echo -n (basename "$VIRTUAL_ENV")
        printf '\e[0m'
        echo -n ']'
    end

    echo -n (printf '\e[90m')'('
    echo -n (date +"%H:%M:%S")
    echo -n ')'(printf '\e[0m')

    if set -q __last_cmd_duration_ms
        if test $__last_cmd_duration_ms -ge 1000
            set -l duration_sec (math "$__last_cmd_duration_ms / 1000.0")
            echo -n '['
            printf '\e[1;35m'
            printf '%.2fs' $duration_sec
            printf '\e[0m'
            echo -n ']'
        end
    end

    echo
    echo -n '╰$ '
end

function __preexec --on-event fish_preexec
    set -g __cmd_start_time (date +%s%N)
end

function __postexec --on-event fish_postexec
    set -l end_time (date +%s%N)
    set -l duration_ns (math "$end_time - $__cmd_start_time")
    set -g __last_cmd_duration_ms (math "($duration_ns) / 1000000")
end

