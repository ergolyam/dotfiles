maki.pack.add({ "https://github.com/ergolyam/maki-codex-status" })
maki.pack.add({ "https://github.com/dkarvik/maki-codex" })

maki.setup({
    ui = {
        theme = 'vscode_dark_plus'
    },
    always_yolo = true,
    net = { allowed_private_hosts = { "chatgpt.com" } }
})
