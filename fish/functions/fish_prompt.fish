function fish_prompt
    set -l reset '\e[0m'
    set -l prompt '╭['

    if test "$USER" = "root"
        set prompt "$prompt\e[1;35m$USER$reset"
    else
        set prompt "$prompt\e[1;92m$USER$reset"
    end
    set prompt "$prompt@"

    set -l hostcolor
    if test -n "$container"
        set hostcolor '\e[1;34m'
    else if test -n "$SSH_CONNECTION"
        set hostcolor '\e[1;38;5;214m'
    else
        set hostcolor '\e[1;31m'
    end

    if test -n "$container_hostname"
      set prompt "$prompt$hostcolor$container_hostname$reset"
    else
      set prompt "$prompt$hostcolor$hostname$reset"
    end
    
    set prompt "$prompt]"

    set -l promptpwd (prompt_pwd)
    set prompt "$prompt""[""\e[1;36m$promptpwd$reset]"

    if type -q git
        if git rev-parse --abbrev-ref HEAD > /dev/null 2>&1
            set -l branch (git rev-parse --abbrev-ref HEAD)
            set prompt "$prompt""[""\e[1;33m$branch$reset]"
        end
    end

    if test -n "$VIRTUAL_ENV"
        set -l pyvenv (basename $VIRTUAL_ENV)
        set prompt "$prompt""[""\e[1;94m$pyvenv$reset]"
    end

    if set -q __last_cmd_duration_ms
        if test $__last_cmd_duration_ms -ge 1000
            set -l duration_sec (math "$__last_cmd_duration_ms / 1000.0")
            set prompt "$prompt""[""\e[1;35m"(printf '%.2fs' $duration_sec)"$reset]"
        end
    end

    set -l time_str (date +"%H:%M:%S")
    set prompt "$prompt\e[90m($time_str)$reset"

    echo -e "$prompt"

    if test "$USER" = "root"
        echo -n '╰# '
    else
        echo -n '╰$ '
    end
end

function __preexec --on-event fish_preexec
    set -g __cmd_start_time (date +%s%N)
end

function __postexec --on-event fish_postexec
    set -l end_time (date +%s%N)
    set -l duration_ns (math "$end_time - $__cmd_start_time")
    set -g __last_cmd_duration_ms (math "($duration_ns) / 1000000")
end

