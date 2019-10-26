local function generate(name)
  print("Lua Plugin Generator")
  print("Generating plugin: " .. name)

  local fsname = name:gsub("[%c%p%s]", "_"):lower()
  os.execute("mkdir " .. fsname)

  local luafile = fsname .. "/" .. fsname .. ".lua"
  local f, err = io.open(luafile, "w")
  if not f then
    error(err)
  end

  f:write(string.format([=[-- define the plugin functions as local functions
local function name()
  return [[%s]]
end

local function version()
  return "1.0.0"
end

local function init()
  print("Init ", name())
end

local function cleanup()
end

-- export the functions to the Lua state
return {
  name = name,
  version = version,
  init = init,
  cleanup = cleanup
}]=], name))
  f:close()
end

return {
  generate = generate
}