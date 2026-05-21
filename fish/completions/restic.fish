function __restic_profiles
    set -l dir "$HOME/.restic"

    test -d "$dir"; or return

    command find "$dir" -maxdepth 1 -type f -print0 2>/dev/null | while read -lz f
        command grep -qE '^[[:space:]]*RESTIC_REPOSITORY[[:space:]]*=' "$f"; or continue

        set -l name (basename "$f")

        set -l repo (
            command sed -nE 's/^[[:space:]]*RESTIC_REPOSITORY[[:space:]]*=[[:space:]]*"?([^"]*)"?[[:space:]]*$/\1/p' "$f" | head -n 1
        )

        test -n "$repo"; or set repo "env file"

        printf "%s\t%s\n" (string escape -- "$name") "repo: $repo"
    end
end

function __restic_completing_profile
    set -l tokens (commandline -opc)

    set -e tokens[1]

    test (count $tokens) -eq 0
end

complete -c restic \
    -n '__restic_completing_profile' \
    -f \
    -a '(__restic_profiles)' \
    -d 'restic profile'
