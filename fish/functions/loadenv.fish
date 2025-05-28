function loadenv
    if test (count $argv) -lt 1
        echo "Usage: loadenv <env_file>"
        return 1
    end

    set env_file $argv[1]

    if not test -f $env_file
        echo "File '$env_file' not found."
        return 1
    end

    if test -n "$__loaded_env"
        if test "$__loaded_env" = "$env_file"
            for var in $__loaded_env_vars
                set -e $var
            end
            set -e __loaded_env
            set -e __loaded_env_vars
            echo "Environment from '$env_file' has been removed."
            return 0
        else
            for var in $__loaded_env_vars
                set -e $var
            end
            set -e __loaded_env
            set -e __loaded_env_vars
        end
    end

    set -g __loaded_env $env_file
    set -g __loaded_env_vars

    while read -l line
        if test -z "$line"
            continue
        end

        if string match -qr '^#' -- $line
            continue
        end

        set key_val (string split -m 1 '=' -- $line)

        if test (count $key_val) -ne 2
            continue
        end

        set variable_name $key_val[1]
        set variable_value (string trim --chars "\"'" -- $key_val[2])

        set -x -g $variable_name $variable_value
        set -a __loaded_env_vars $variable_name

    end < $env_file

    echo "Environment from '$env_file' has been loaded."
end
