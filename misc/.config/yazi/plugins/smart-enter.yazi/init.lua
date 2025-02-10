---@diagnostic disable: undefined-global

return {
	entry = function(self, args)
		local h = cx.active.current.hovered
    if h and h.cha.is_dir then
      ya.manager_emit("enter", {})
      return
    end

    if #args == 0 then
      ya.manager_emit("open", {})
    end

    if args[1] == "detatch" then
      os.execute(string.format("opener detatch \"%s\"", h.url))
    elseif args[1] == "list" then
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
	end,
}

