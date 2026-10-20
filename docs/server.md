# Server Preparation

Shared setup for [Mineclonia](mineclonia.md) and [VPN](vpn.md). Requires systemd, rootless Podman with Quadlet, Fish, and SSH access. Complete this before `chezmoi apply`.

## Host setup

Run as an administrator. Replace `user` with `vpn` or `mineclonia` for the respective server:
```sh
sudo adduser --disabled-password user
sudo loginctl enable-linger user
```

Linger keeps the user's systemd services running after logout.

Check the network target:
```sh
systemctl is-active network-online.target
```

If it is not `active`, run:
```sh
sudo systemctl add-wants multi-user.target network-online.target
sudo systemctl start network-online.target
```

This avoids unnecessary delays when starting rootless Podman Quadlets.

## Service user

After any host-specific setup, switch to the dedicated service user (replace `user` with the account name):
```sh
sudo -iu user fish
```

Initialize and apply chezmoi under this account, not as root.
