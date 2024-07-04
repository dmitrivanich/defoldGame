local M = {}

function M.getPointOnCircle(radius, angleRad)
	local x = radius * math.cos(angleRad)
	local y = radius * math.sin(angleRad)
	return x, y
end

function M.calculate_size(size, number)
	local newSize = (size * 5) / number

	if newSize > size then return size
	else return newSize end
end

return M