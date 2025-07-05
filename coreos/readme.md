# fedora-coreos

- Install livecd image:
    ```bash
    coreos-installer download \
        -s stable \
        -p metal \
        -f iso
    ```

- Creation and configuration of a settings file:
    ```bash
    HOSTNAME="your-hostname" \
    PASSWD=$(mkpasswd --method=yescrypt) \
    PUBKEY=$(cat /path/to/your-key.pub)
        envsubst < config.bu | butane --pretty --strict > config.ign
    ```

- Embedding a configuration file into a livecd image:
    ```bash
    coreos-installer iso customize \
        --dest-device /dev/drive \
        --dest-ignition config.ign \
        --dest-console ttyS0,115200n8 \
        --dest-console tty0 \
        -o custom-fedora-coreos.iso fedora-coreos-*.iso
    ```
    - Instead of `/dev/drive`, insert your path to the drive.
