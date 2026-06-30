function bash
    set -l symbol '$'
    set -l user_color '\\[\\e[1;92m\\]'
    set -l host_color '\\[\\e[1;31m\\]'
    set -l the_host '\\h'

    if test $USER = 'root'
        set symbol '#'
        set user_color '\\[\\e[1;35m\\]'
    end

    if set -q container
        set host_color '\\[\\e[1;34m\\]'
        set the_host $container_hostname
    else if set -q SSH_CONNECTION
        set host_color '\\[\\e[1;38;5;214m\\]'
        set the_host '\\h'
    end

    set -l reset '\\[\\e[0m\\]'

    set -l part_user "╭["$user_color"\\u"$reset"@"$host_color$the_host$reset"]"
    set -l part_pwd  "[""\\[\\e[1;36m\\]\\w"$reset"]"
    set -l part_info "[""\\[\\e[1;35m\\]bash"$reset"]"
    set -l part_time "\\[\\e[90m\\](\\t)"$reset""

    set -l line1 $part_user$part_pwd$part_info$part_time

    set -l line2 "╰"$symbol" "

    set -lx PS1 "$line1\n$line2"
    set -lx HISTFILE /dev/null
    /usr/bin/bash --noprofile --norc $argv
end
