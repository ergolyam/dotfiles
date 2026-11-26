function codex --description "Run codex in a persistent podman container"
    set -l dir_hash (echo -n "$PWD" | sha256sum | cut -c1-12)
    set -l container_name "codex-$dir_hash"
    set -l tmpdir "/tmp/codex-$dir_hash"

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

    mkdir -p "$tmpdir" "$HOME/.local/share/codex"

    if not podman container exists "$container_name"
        set -l podman_args

        if set -q PODMAN_ARGS[1]
            echo -- "$PODMAN_ARGS" | read --tokenize --array podman_args
            or return $status
        end

        podman run -d --pull newer \
            --name "$container_name" \
            -e TZ=Europe/Moscow \
            -e TERM=$TERM \
            -v "$tmpdir:/tmp:z" \
            -v "$HOME/.local/share/codex:/data:z" \
            -v "$PWD:$PWD:z" \
            --workdir "$PWD" \
            $podman_args \
            --entrypoint sleep \
            ghcr.io/ergolyam/agents-docker/codex:latest \
            infinity

        or return $status
    end

    if test (podman inspect -f '{{.State.Running}}' "$container_name") != true
        podman start "$container_name"
        or return $status
    end

    podman exec -it "$container_name" entrypoint.sh $argv
end
