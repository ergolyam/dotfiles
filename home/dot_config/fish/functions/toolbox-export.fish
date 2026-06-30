function toolbox-export
    set mode "usrbin"
    set list_mode false
    set args

    for a in $argv
        switch $a
            case '--path'
                set mode "path"
            case '--list'
                set list_mode true
            case '*'
                set args $args $a
        end
    end

    if test "$list_mode" = true
        set dir "$HOME/.local/bin"

        if not test -d $dir
            echo "No ~/.local/bin directory"
            return 0
        end

        echo "Toolbox wrappers:"
        set any false
        for f in $dir/*
            if test -f "$f"
                set name (basename "$f")
                if grep -q "exec toolbox run $name" "$f"
                    echo "  $name"
                    set any true
                end
            end
        end

        if test "$any" = false
            echo "  (none)"
        end

        return 0
    end


    set bin $args[1]

    if test -z "$bin"
        echo "Usage:"
        echo "  toolbox-export <binary>"
        echo "  toolbox-export --path <binary>"
        echo "  toolbox-export --list"
        return 1
    end

    set outfile "$HOME/.local/bin/$bin"

    if test -f "$outfile"
        if grep -q "exec toolbox run $bin" "$outfile"
            echo "Wrapper already exists: $outfile"
            echo "Skip."
            return 0
        else
            echo "File '$outfile' already exists and is not a toolbox wrapper."
            echo "Refusing to overwrite."
            return 1
        end
    end

    if test "$mode" = "usrbin"
        if toolbox run test -x "/usr/bin/$bin"
            set realpath "/usr/bin/$bin"
        else
            echo "Error: binary '$bin' not found inside toolbox (/usr/bin/$bin)"
            return 1
        end
    else if test "$mode" = "path"
        set found (toolbox run sh -c "which $bin 2>/dev/null")
        if test -z "$found"
            echo "Error: binary '$bin' not found in toolbox PATH"
            return 1
        end
        set realpath $found
    end

    echo "#!/usr/bin/env sh" > $outfile
    echo "if [ \"\$container\" = \"oci\" ]; then" >> $outfile
    echo "    exec $realpath \"\$@\"" >> $outfile
    echo "fi" >> $outfile
    echo "exec toolbox run $bin \"\$@\"" >> $outfile

    chmod +x $outfile

    echo "Created wrapper: $outfile"
    echo " → inside toolbox calls: $realpath"
end

