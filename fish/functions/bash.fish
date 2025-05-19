function bash
    set symbol '$'
    set user_color '\\[\\e[1;92m\\]'
    set host_color '\\[\\e[1;31m\\]'
    set the_host '\\h'

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

    set reset '\\[\\e[0m\\]'

    set part_user "╭["$user_color"\\u"$reset"@"$host_color$the_host$reset"]"
    set part_pwd  "[""\\[\\e[1;36m\\]\\w"$reset"]"
    set part_time "\\[\\e[90m\\](\\t)"$reset""

    set line1 $part_user$part_pwd$part_time

    set line2 "╰"$symbol" "

    set -lx PS1 "$line1\n$line2"
    set -lx HISTFILE /dev/null
    /usr/bin/bash --noprofile --norc $argv
end
