#!/usr/bin/env luajit

-- env: BARS_NUMBER, SENSITIVITY
local BARS_NUMBER = tonumber(os.getenv("BARS_NUMBER") or "12") or 12
local OUTPUT_BIT_FORMAT = "16bit"         -- "16bit" или "8bit"
local RAW_TARGET = "/dev/stdout"
local SENSITIVITY = tonumber(os.getenv("SENSITIVITY") or "150") or 150

local CONFIG_TPL = [[
[general]
bars = %d
sensitivity = %d
[output]
method = raw
raw_target = %s
bit_format = %s
]]

local SYMBOLS = {"▁","▂","▃","▄","▅","▆","▇","█"}
local COLORS  = {"d3c6aa","7fbbb3","d699b6","e67e80","e69875","dbbc7f","a7c080","83c092"}

local function make_config()
  return string.format(CONFIG_TPL, BARS_NUMBER, SENSITIVITY, RAW_TARGET, OUTPUT_BIT_FORMAT)
end

local function write_tmp_config(content)
  local tmpname = os.tmpname()
  local f, err = io.open(tmpname, "wb")
  if not f then
    io.stderr:write("failed to open temp file: ", err or "unknown", "\n")
    os.exit(1)
  end
  f:write(content)
  f:close()
  return tmpname
end

local function main()
  local config = make_config()
  local cfg_path = write_tmp_config(config)

  local bytesize, bytenorm
  if OUTPUT_BIT_FORMAT == "16bit" then
    bytesize, bytenorm = 2, 65535
  else
    bytesize, bytenorm = 1, 255
  end

  local chunk_size = bytesize * BARS_NUMBER
  local src = io.popen("cava -p " .. cfg_path, "r")
  if not src then
    io.stderr:write("failed to start cava\n")
    os.remove(cfg_path)
    os.exit(1)
  end

  local denom = bytenorm + 1

  -- читаем строго фиксированными чанками
  while true do
    local data = src:read(chunk_size)
    if not data or #data < chunk_size then
      break
    end

    local parts = {}
    if bytesize == 2 then
      -- 16-bit little-endian
      local j = 1
      for i = 1, chunk_size, 2 do
        local lo = data:byte(i)
        local hi = data:byte(i + 1)
        local v = lo + hi * 256
        local idx = math.floor(v * 8 / denom)
        if idx > 7 then idx = 7 end
        parts[j] = "<span foreground='#" .. COLORS[idx + 1] .."'>" .. SYMBOLS[idx + 1] .. "</span>"
        j = j + 1
      end
    else
      -- 8-bit
      for j = 1, BARS_NUMBER do
        local v = data:byte(j)
        local idx = math.floor(v * 8 / denom)
        if idx > 7 then idx = 7 end
        parts[j] = "<span foreground='#" .. COLORS[idx + 1] .."'>" .. SYMBOLS[idx + 1] .. "</span>"
      end
    end

    local text = table.concat(parts)
    -- io.write(text, "\n")
    -- io.flush()
    -- для JSON-вывода:
    io.write(string.format('{"text":"%s"}\n', text)); io.flush()
  end

  src:close()
  os.remove(cfg_path)
end

main()

