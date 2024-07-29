# Installing and configuring wayblue on steam deck.

## Installing fedora atomic.

1. Download and install any ferdora atomic image.

[Atomic-Desktops](https://fedoraproject.org/atomic-desktops/)

2. Perform a reset to remove all the overwritten packages and avoid problems.
    ```bash
    rpm-ostree reset &&\
    reboot
    ```

## Wayblue rebase.

1. Rebase an unsigned image with hyprland.
    ```bash
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/wayblueorg/hyprland:latest &&\
    reboot
    ```

2. After that we rebase the signed image from hyprland.
    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/wayblueorg/hyprland:latest &&\
    reboot
    ```

## Optimization for steam deck.

### Setting up fedora corp repositories.

- Connecting the bazzite repository.
    ```bash
    sudo wget -O /etc/yum.repos.d/kylegospo-bazzite-fedora-40.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-40/kylegospo-bazzite-fedora-40.repo
    ```

- Connecting the bazzite-multilib repository.
    ```bash
    sudo wget -O /etc/yum.repos.d/kylegospo-bazzite-multilib-fedora-40.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-40/kylegospo-bazzite-multilib-fedora-40.repo?arch=x86_64
    ```

- Connecting the kernel-fsync repository.
    ```bash
    sudo wget -O /etc/yum.repos.d/sentry-kernel-fsync-fedora-40.repo https://copr.fedorainfracloud.org/coprs/sentry/kernel-fsync/repo/fedora-40/sentry-kernel-fsync-fedora-40.repo
    ```

- Connecting the scx_lavd repository.
    ```bash
    sudo wget -O /etc/yum.repos.d/kylegospo-scx_lavd-fedora-40.repo https://copr.fedorainfracloud.org/coprs/kylegospo/scx_lavd/repo/fedora-40/kylegospo-scx_lavd-fedora-40.repo
    ```

### Installing the package.

1. Install kernel-fsync.
    ```bash
    sudo rpm-ostree override replace --experimental --from repo='copr:copr.fedorainfracloud.org:sentry:kernel-fsync' kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra &&\
    reboot
    ```

2. Install patched versions mesa, pipewire for steam deck.
    ```bash
    sudo rpm-ostree override replace --experimental --from repo='copr:copr.fedorainfracloud.org:kylegospo:bazzite-multilib' mesa-filesystem mesa-libglapi mesa-dri-drivers mesa-libgbm mesa-libEGL mesa-vulkan-drivers mesa-libGL xorg-x11-server-Xwayland pipewire pipewire-alsa pipewire-gstreamer pipewire-jack-audio-connection-kit pipewire-jack-audio-connection-kit-libs pipewire-libs pipewire-pulseaudio pipewire-utils &&\
    reboot
    ```

3. Install the utils.
    ```bash
    rpm-ostree install powerbuttond python-python-pidfile python3-hid jupiter-fan-control jupiter-hw-support-btrfs ryzenadj scx_lavd steam lutris gamescope gamescope-shaders gamescope-session-plus gamescope-session-steam mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686 mangohud vpower wlogout hyprpaper &&\
    reboot
    ```

### Preparing the necessary files.

1. Preparing a custom gamescope-session.
    ```bash
    sudo mkdir /usr/local/share/wayland-sessions &&\
    sudo cp /usr/share/wayland-sessions/gamescope-session.desktop /usr/local/share/wayland-sessions/gamescope-session-custom.desktop &&\
    sudo sed -i 's|Exec=gamescope-session-plus steam|Exec=/usr/share/gamescope-session-plus/gamescope-session-plus steam|' /usr/local/share/wayland-sessions/gamescope-session-custom.desktop &&\
    sudo sed -i 's|Name=Steam Big Picture|Name=Gamescope Session|' /usr/local/share/wayland-sessions/gamescope-session-custom.desktop
    ```
    - Hiding standard sessions.
        ```bash
        sudo cp /usr/share/wayland-sessions/gamescope-session* /usr/local/share/wayland-sessions/ &&\
        sudo find /usr/local/share/wayland-sessions/ -type f -name 'gamescope-session*' | grep -v 'gamescope-session-custom.desktop' | xargs -I {} sudo sed -i '/^\[Desktop Entry\]/a Hidden=true' {}
        ```

2. Automount sd cards.
    ```bash
    sudo bash -c "cat > /etc/systemd/system/automount-sd.service <<EOF
    [Unit]
    Description=Automount SD Card
    After=udisks2.service

    [Service]
    Type=oneshot
    User=$USER
    ExecStart=/usr/bin/bash -c '/usr/bin/udisksctl mount -b /dev/mmcblk0p1'
    ExecStop=/usr/bin/bash -c '/usr/bin/udisksctl unmount -b /dev/mmcblk0p1'
    RemainAfterExit=true
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    EOF" &&\
    sudo systemctl daemon-reload &&\
    sudo systemctl enable automount-sd.service &&\
    sudo systemctl start automount-sd.service 
    ```
    - ***Before removing the SD card, it is recommended to run `sudo systemctl stop automount-sd.service` or turn off the device `poweroff`.***

