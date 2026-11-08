function maki --description "Run Maki in a persistent podman container"
    set -l dir_hash (echo -n "$PWD" | sha256sum | cut -c1-12)
    set -l container_name "maki-$dir_hash"
    set -l tmpdir "/tmp/maki-$dir_hash"

    mkdir -p "$tmpdir" "$HOME/.local/share/maki"

    if not podman container exists "$container_name"
        podman run -d --pull newer \
            --name "$container_name" \
            --entrypoint sleep \
            -v "$tmpdir:/tmp:z" \
            -v "$HOME/.local/share/maki:/data:z" \
            -v "$PWD:$PWD:z" \
            --workdir "$PWD" \
            ghcr.io/ergolyam/agents-docker/maki:latest \
            infinity

        or return $status
    end

    if test (podman inspect -f '{{.State.Running}}' "$container_name") != true
        podman start "$container_name"
        or return $status
    end

    podman exec -it "$container_name" entrypoint.sh $argv
end
