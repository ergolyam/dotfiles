function maki --description "Run Maki in a podman container"
    set -l dir_hash (echo "$PWD" | sha256sum | cut -c1-12)
    set -l tmpdir /tmp/maki-$dir_hash

    mkdir -p $tmpdir

    podman run --rm -it --pull newer \
        --name maki-$dir_hash \
        -v "$tmpdir:/tmp:z" \
        -v "$HOME/.local/share/maki:/data:z" \
        -v "$PWD:$PWD:z" \
        --workdir "$PWD" \
        ghcr.io/ergolyam/agents-docker/maki:latest \
        $argv
end
