function codex --description "Run codex-cli in a podman container"
    set -l dirs
    set -l modes
    set -l args

    while set -q argv[1]
        switch $argv[1]
            case '-w:*'
                if not set -q argv[2]
                    echo "codex: missing directory after $argv[1]" >&2
                    return 2
                end

                set -a dirs $argv[2]
                set -a modes (string sub -s 4 -- $argv[1])
                set -e argv[1..2]

            case '--'
                set args $argv[2..-1]
                break

            case '*'
                echo "codex: unknown argument $argv[1]" >&2
                return 2
        end
    end

    set -l mounts
    for i in (seq 1 (count $dirs))
        set -l target /work

        if test (count $dirs) -gt 1
            set target /work/(path basename -- $dirs[$i])
        end

        set -a mounts -v "$dirs[$i]:$target:$modes[$i]"
    end

    command podman run --pull newer --name codex --rm -it \
        -e TERM=$TERM \
        -e TZ=Europe/Moscow \
        --network container:tun2socks \
        -v "$HOME/.local/share/codex:/data:Z" \
        $mounts \
        ghcr.io/ergolyam/codex-docker:latest $args
end
