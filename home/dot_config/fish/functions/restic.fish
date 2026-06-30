function restic --description "Run restic profile from ~/.restic/<profile>"
    set -l profile $argv[1]
    set -e argv[1]

    test -n "$profile"; or set profile postgres
    set -l envfile "$HOME/.restic/$profile"

    test -f "$envfile"; or begin
        echo "env file not found: $envfile" >&2
        return 1
    end

    echo "Run restic profile from $envfile"
    podman run -it --rm \
        -e TZ=Europe/Moscow \
        -v "$HOME/.restic:/root/.ssh:ro" \
        -v restic-cache:/root/.cache/restic \
        --env-file="$envfile" \
        docker.io/restic/restic $argv
end
