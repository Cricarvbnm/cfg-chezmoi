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

hl.bind("SUPER + Backspace", zoom)
hl.bind("SUPER + equal", function()
	zoom(0.5)
end)
hl.bind("SUPER + minus", function()
	zoom(-0.5)
end)
