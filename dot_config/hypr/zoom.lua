local MAX_ZOOM = 3
local MIN_ZOOM = 1

---@param offset number | nil
---@return nil
local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	if offset == nil then
		current = MIN_ZOOM
	else
		current = current + offset
		current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	end
	hl.config({ cursor = { zoom_factor = current } })
end

require("keybindings")

hl.bind(MAIN_MOD .. " + Backspace", zoom)
hl.bind(MAIN_MOD .. " + equal", function()
	zoom(0.5)
end)
hl.bind(MAIN_MOD .. " + minus", function()
	zoom(-0.5)
end)
