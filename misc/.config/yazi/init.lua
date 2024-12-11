---@diagnostic disable: undefined-global

-- Sync yank clipboard across instances
require("session"):setup {
	sync_yanked = true,
}

-- Show username and hostname in header
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ui.Line {}
	end
	return ui.Line { ui.Span(ya.user_name() .. "@" .. ya.host_name()):fg("lightgreen"):bold(true), ui.Span(":") }
end, 500, Header.LEFT)

-- Show the path of the currently hovered file in the header
function Header:cwd()
	local max = self._area.w - self._right_width
	if max <= 0 then
		return ui.Span("")
	end

	local cwd = ya.readable_path(tostring(self._tab.current.cwd)) .. self:flags()
	local left = ui.Line {
    ui.Span(cwd):fg("blue"):bold(true),
    ui.Span("/"):fg("blue"):bold(true),
    ui.Span(tostring(cx.active.current.hovered.name)):fg("white"):   bold(true),
  }

  return left

end

-- Remove file size from status bar
function Status:size()
end

-- Remove percentage from status bar
function Status:percentage()
end

-- Show symlink path in status bar
function Status:name()
	local h = self._tab.current.hovered
	if not h then
		return ui.Line {}
	end

  local linked = ""
 	if h.link_to ~= nil then
 		linked = " -> " .. tostring(h.link_to)
 	end
 	return ui.Line(" " .. h.name .. linked)
end

