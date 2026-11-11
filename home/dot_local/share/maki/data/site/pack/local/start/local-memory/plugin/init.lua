local cwd = maki.uv.cwd()
local state = maki.env.state_dir()
if not cwd or not state then
  maki.log.warn("local_memory: cannot resolve cwd or state directory")
  return
end

local root = maki.fs.root(cwd, ".git") or cwd

local function project_hash(path)
  local lo, hi = 0x84222325, 0xcbf29ce4
  for i = 1, #path do
    lo = bit32.bxor(lo, path:byte(i))
    local product = lo * 0x1b3
    local carry = math.floor(product / 0x100000000)
    hi = (hi * 0x1b3 + lo * 0x100 + carry) % 0x100000000
    lo = product % 0x100000000
  end
  return string.format("%08x%08x", hi, lo)
end

local project_id = (maki.fs.basename(root) or "root") .. "-" .. project_hash(root)
local source = maki.fs.joinpath(state, "projects", project_id, "memories")
local target = maki.fs.joinpath(root, ".maki", "memories")

local script = [[
set -eu
source=$1
target=$2
mkdir -p "$(dirname "$source")" "$(dirname "$target")"
if [ -L "$source" ]; then
  if [ "$(readlink "$source")" != "$target" ]; then
    echo "memory location already points elsewhere: $source" >&2
    exit 1
  fi
  mkdir -p "$target"
elif [ -d "$source" ]; then
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "both memory directories exist; merge manually: $source and $target" >&2
    exit 1
  fi
  mv "$source" "$target"
  ln -s "$target" "$source"
elif [ -e "$source" ]; then
  echo "memory path is not a directory: $source" >&2
  exit 1
else
  mkdir -p "$target"
  ln -s "$target" "$source"
fi
]]

local job, start_err = maki.fn.jobstart({ "sh", "-c", script, "local-memory", source, target }, { scope = "plugin" })
if not job then
  maki.log.warn("local_memory: " .. tostring(start_err))
  return
end

local result, wait_err = maki.fn.jobwait(job, 30000)
if not result then
  maki.log.warn("local_memory: " .. tostring(wait_err))
elseif result.exit_code ~= 0 then
  maki.log.warn("local_memory: " .. (result.stderr or "symlink setup failed"))
end
