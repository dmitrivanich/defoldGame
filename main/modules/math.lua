local M = {}

function M.getPointOnCircle(radius, angleRad)
	local x = radius * math.cos(angleRad)
	local y = radius * math.sin(angleRad)
	return x, y
end

return M