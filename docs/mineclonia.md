# Mineclonia Server

Luanti/Mineclonia and PostgreSQL in rootless Podman Quadlets, with optional Telegram backups.

## Setup

1. Complete [server preparation](server.md) with the user name `mineclonia`, then switch to it with `sudo -iu mineclonia fish`.
2. Initialize chezmoi as described in the [installation guide](../readme.md#installation). Set `~/.config/chezmoi/chezmoi.toml` to:
    ```toml
    [data]
    profile = "default"
    server_type = "mineclonia"
    ```

3. Apply and fill in the generated private environment file:
    ```sh
    chezmoi apply
    $EDITOR ~/.config/containers/systemd/mineclonia/mcl.env
    ```
    > Set `POSTGRES_PASSWORD` and `PGPASSWORD` to the same strong password. The database and user names are already configured.

## Start

```sh
systemctl --user daemon-reload
systemctl --user enable --now mineclonia.target
systemctl --user enable --now podman-auto-update.timer
```
> The game server listens on `30000/udp`. World and database data are stored in `~/data/mcl-data` and `~/data/mcl-db`.

## Backups (optional)

Fill in `TG_TOKEN` and `TG_CHAT_ID` in `~/.config/containers/systemd/mineclonia/mcl-backup.env`, then enable:
```sh
systemctl --user enable --now mcl-backup-smart.timer
```

The timer checks every six hours (Europe/Moscow) and backs up only after recent player activity. Archives are saved to `~/data/mcl-backup` and uploaded to Telegram.
