#!/bin/sh

unset ID VERSION_ID ID_LIKE

if [ -r /etc/os-release ]; then
    . /etc/os-release
elif [ -r /usr/lib/os-release ]; then
    . /usr/lib/os-release
fi

distro="${ID:-unknown}"
version="${VERSION_ID:-unknown}"

manager_for() {
    case "$1" in
        alpine)    printf '%s\n' apk ;;
        fedora)    printf '%s\n' dnf ;;
        debian)    printf '%s\n' apt ;;
        nix|nixos) printf '%s\n' nix ;;
    esac
}

manager="$(manager_for "$distro")"

if [ -z "$manager" ]; then
    set -f

    for family in ${ID_LIKE:-}; do
        manager="$(manager_for "$family")"
        [ -n "$manager" ] && break
    done

    set +f
fi

cat <<EOF
# Execution Environment
- Container runtime: Podman (rootless)
- Distribution: $distro $version
- Expected package manager: ${manager:-unknown}
- Init system: No systemd inside the container

## Environment Rules
- Verify that the expected package manager is installed.
- You may install required development dependencies without prior user confirmation.
- Use available root privileges freely within the container.
- Do not assume systemd or unrestricted host filesystem access.
EOF

