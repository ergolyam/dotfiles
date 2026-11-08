local managers = {
  alpine = "apk",
  fedora = "dnf",
  debian = "apt",
  nix = "nix"
}

local function field(data, key)
  for line in (data or ""):gmatch("[^\r\n]+") do
    local k, value = line:match("^([%w_]+)=(.*)$")
    if k == key then
      return (value:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1"))
    end
  end
end

local function detect_environment()
  local os = maki.fs.read("/etc/os-release")
  local distro = field(os, "ID") or "unknown"
  local version = field(os, "VERSION_ID") or "unknown"

  local manager = managers[distro]

  if not manager then
    for family in (field(os, "ID_LIKE") or ""):gmatch("%S+") do
      manager = managers[family]
      if manager then break end
    end
  end

  return string.format([[

# Execution Environment
- Container runtime: Podman (rootless)
- Distribution: %s %s
- Expected package manager: %s
- Shell: /bin/bash
- Init system: No systemd inside the container

## Environment Rules
- Verify that the expected package manager is installed.
- You may install required development dependencies without prior user confirmation.
- Use available root privileges freely within the container.
- Do not assume systemd or unrestricted host filesystem access.]], distro, version, manager or "unknown")
end

maki.api.register_prompt_hint({
  prompt = "system",
  slot = "conventions",
  content = detect_environment,
})
