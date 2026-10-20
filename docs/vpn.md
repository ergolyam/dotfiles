# VPN Server

Rootless 3x-ui/Xray with VLESS/Reality, Nginx TLS fallback, automatic ACME certificates, and optional Telegram backups.

## Before `chezmoi apply`

1. Point your domain's DNS A record to the VPS and allow `80/tcp` and `443/tcp` (both must be free).
2. As an administrator, set the VPN-only sysctl values. They allow rootless Podman to bind low ports and enable BBR:
    ```sh
    echo "net.ipv4.ip_unprivileged_port_start=80" | sudo tee /etc/sysctl.d/99-unprivileged-ports.conf
    echo -e "net.core.default_qdisc=fq\nnet.ipv4.tcp_congestion_control=bbr" | tee /etc/sysctl.d/99-bbr.conf
    sudo sysctl --system
    ```
3. Complete [server preparation](server.md) with the user name `vpn`, then switch to it with `sudo -iu vpn fish`.
4. Initialize chezmoi as described in the [installation guide](../readme.md#installation). Set `~/.config/chezmoi/chezmoi.toml` to:
    ```toml
    [data]
    profile = "default"
    server_type = "vpn"
    domain = "example.com"
    ```
    > Replace `example.com` with your domain, then run `chezmoi apply`.

## Start

```sh
systemctl --user daemon-reload
systemctl --user enable --now vpn.target
systemctl --user enable --now acme-renew.timer podman-auto-update.timer
```

The first start issues a Let's Encrypt certificate through `acme-init.service` before Nginx starts. `acme-renew.timer` handles renewals; the Podman timer updates container images.

Check services with `systemctl --user status 3x-ui.service nginx.service --no-pager`.

## 3x-ui: VLESS/Reality

The panel is bound to localhost. From your workstation, open an SSH tunnel:
```sh
ssh -L 2053:127.0.0.1:2053 <ssh-user>@<server-ip>
```
> Open `http://127.0.0.1:2053` and change the initial admin credentials.

Under **Inbounds -> Add Inbound**, set:

| Setting | Value |
| ------- | ----- |
| Remark / Protocol | `vless-reality` / `vless` |
| Port / Security | `443` / `Reality` |
| Target | `10.50.0.11:8443` |
| SNI | `example.com` (your domain) |
| Keys | **Get New Cert** |
| Sniffing | Enabled: HTTP and TLS, **Route only** |

Click **Create**.

Under **Clients -> Add Client**, enter an **Email** (client name), set **Flow** to `xtls-rprx-vision`, attach the `vless-reality` inbound, and click **Create**.

For subscriptions, set **Panel Settings -> Subscription -> Reverse Proxy URI** to `https://example.com/sub/`, save, and restart the panel. Use **Clients -> More information -> Subscription info -> Sub** to copy the client's subscription URL.

## Backups (optional)

Set `TG_TOKEN` and `TG_CHAT_ID` in `~/.config/containers/systemd/vpn/vpn-backup.env` (and `PROXY` if needed), then enable the daily database backup:
```sh
systemctl --user enable --now vpn-backup.timer
```
