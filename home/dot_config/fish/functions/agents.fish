function codex --description "Run agent in a persistent podman container"
    set -l agent (status function)
    set -l dir_hash (echo -n "$PWD" | sha256sum | cut -c1-12)
    set -l container_name "$agent-$dir_hash"
    set -l tmpdir "/tmp/$container_name"
    set -l datadir "$HOME/.local/share/$agent"

    if test "$argv[1]" = clean
        if podman container exists "$container_name"
            podman rm -f --time 0 "$container_name"
            and rm -rf -- "$tmpdir"
            or return $status
            echo "Cleaned up $container_name"
        else
            echo "Nothing to clean: $container_name"
        end
        return 0
    end

    mkdir -p "$tmpdir" "$datadir"
    or return $status

    if not podman container exists "$container_name"
        set -l podman_args

        if set -q PODMAN_ARGS[1]
            echo -- "$PODMAN_ARGS" | read --tokenize --array podman_args
            or return $status
        end

        podman run -d --pull newer \
            --name "$container_name" \
            -e TZ=Europe/Moscow \
            -e TERM="$TERM" \
            -v "$tmpdir:/tmp:z" \
            -v "$datadir:/data:z" \
            -v "$PWD:$PWD:z" \
            --workdir "$PWD" \
            --entrypoint sleep \
            $podman_args \
            "ghcr.io/ergolyam/agents-docker/$agent:latest" \
            infinity

        or return $status
    end

    if test (podman inspect -f '{{.State.Running}}' "$container_name") != true
        podman start "$container_name"
        or return $status
    end

    podman exec -it "$container_name" entrypoint.sh $argv
end

functions --copy codex maki
