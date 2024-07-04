local A = {}

local color_mini_cell_text = vmath.vector4(77 / 255, 77 / 255, 77 / 255, 1)

function A.animate_show(id, duration)
	local node = gui.get_node(id)

	gui.animate(node, "color.w", 1, gui.EASING_OUTEXPO, duration)
	gui.animate(node, "color.w", 1, gui.EASING_OUTEXPO, duration)
	gui.animate(node, "color.w", 1, gui.EASING_OUTEXPO, duration)
	gui.animate(node, "color.w", 1, gui.EASING_OUTEXPO, duration)
end

function A.animate_hide(id, duration)
	local node = gui.get_node(id)

	gui.animate(node, "color.w", 0, gui.EASING_OUTEXPO, duration)
	gui.animate(node, "color.w", 0, gui.EASING_OUTEXPO, duration)
	gui.animate(node, "color.w", 0, gui.EASING_OUTEXPO, duration)
	gui.animate(node, "color.w", 0, gui.EASING_OUTEXPO, duration)
end

function A.cell_ring_selection(cell_id) 
	sound.play("main:/sounds#tap")
	
	local cell = gui.get_node(cell_id)
	local cell_text = gui.get_node(cell_id .. "_text")
	local cell_pink = gui.get_node(cell_id .. "_pink")

	--scale
	gui.animate(cell, "scale.x", 0.9, gui.EASING_LINEAR, 0.1, 0, 
		function () gui.animate(cell, "scale.x", 1, gui.EASING_LINEAR, 0.1) end
	)
	
	gui.animate(cell, "scale.y", 0.9, gui.EASING_LINEAR, 0.1, 0, 
		function () gui.animate(cell, "scale.y", 1, gui.EASING_LINEAR, 0.1) end
	)
	
	--alpha
	gui.animate(cell_pink, "color.w", 1, gui.EASING_LINEAR, 0.2)

	--color
	gui.animate(cell_text, "color.x", 1, gui.EASING_LINEAR, 0.2)
	gui.animate(cell_text, "color.y", 1, gui.EASING_LINEAR, 0.2)
	gui.animate(cell_text, "color.z", 1, gui.EASING_LINEAR, 0.2)
end

function A.cell_ring_unselection(cell_id) 
	local delay = 0.1
	local cell = gui.get_node(cell_id)
	local cell_text = gui.get_node(cell_id .. "_text")
	local cell_pink = gui.get_node(cell_id .. "_pink")

	--scale
	gui.animate(cell, "scale.x", 1.1, gui.EASING_LINEAR, 0.1, delay, 
		function () gui.animate(cell, "scale.x", 1, gui.EASING_LINEAR, 0.1) end
	)

	gui.animate(cell, "scale.y", 1.1, gui.EASING_LINEAR, 0.1, delay, 
		function () gui.animate(cell, "scale.y", 1, gui.EASING_LINEAR, 0.1) end
	)

	--alpha
	gui.animate(cell_pink, "color.w", 0, gui.EASING_LINEAR, 0.2, delay)

	--color
	gui.animate(cell_text, "color.x", color_mini_cell_text.x, gui.EASING_LINEAR, 0.2, delay)
	gui.animate(cell_text, "color.y", color_mini_cell_text.y, gui.EASING_LINEAR, 0.2, delay)
	gui.animate(cell_text, "color.z", color_mini_cell_text.z, gui.EASING_LINEAR, 0.2, delay)
end

return A