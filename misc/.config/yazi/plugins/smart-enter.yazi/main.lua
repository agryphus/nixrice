--- @since 25.2.26
--- @sync entry

local function setup(self, opts) self.open_multi = opts.open_multi end

local function entry(_, job)
  local h = cx.active.current.hovered
  if h and h.cha.is_dir then
    ya.manager_emit("enter", {})
    return
  end

  if #job.args == 0 then
    ya.manager_emit("open", {})
  end

  if job.args[1] == "detatch" then
    os.execute(string.format("opener detatch \"%s\"", h.url))
  elseif job.args[1] == "list" then
    local f = assert(io.popen(string.format(
      "opener list \"%s\"", h.url), 'r'))
    local out = assert(f:read('*a'))
    f:close()
    ya.notify {
      title = string.format("Openers for %s:", h.name),
      content = out,
      timeout = 6.5,
      level = "info",
    }
  end
end


return { entry = entry, setup = setup }

