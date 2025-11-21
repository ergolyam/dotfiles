function toolbox-export
    set bin $argv[1]

    if test -z "$bin"
        echo "Usage: toolbox-export <binary>"
        return 1
    end

    if not toolbox run test -x "/usr/bin/$bin"
        echo "Error: binary '$bin' not found inside toolbox (/usr/bin/$bin)"
        return 1
    end

    set outfile "$HOME/.local/bin/$bin"

    echo "#!/usr/bin/env sh" > $outfile
    echo "if [ \"\$container\" = \"oci\" ]; then" >> $outfile
    echo "    exec /usr/bin/$bin \"\$@\"" >> $outfile
    echo "fi" >> $outfile
    echo "exec toolbox run $bin \"\$@\"" >> $outfile

    chmod +x $outfile

    echo "Created wrapper: $outfile"
end

