local math = require("main.modules.math")
local utf8 = require("main.modules.utf8")

local N = {}

function N.create_cell(char, word, size, x, y) 
	local parent_node = gui.get_node("words")
	
	local cell = gui.new_box_node(vmath.vector3(x, y, 0), vmath.vector3(size, size, 0))
	gui.set_parent(cell, parent_node)
	gui.set_alpha(cell, 0)

	local white_cell = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
	gui.set_parent(white_cell, cell)
	gui.set_texture(white_cell, "assets")
	gui.play_flipbook(white_cell, "cell_white")
	gui.set_size(white_cell, vmath.vector3(size, size, 0))

	local green_cell = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
	gui.set_parent(green_cell, cell)
	gui.set_texture(green_cell, "assets")
	gui.play_flipbook(green_cell, "cell_green")
	gui.set_size(green_cell, vmath.vector3(size, size, 0))
	gui.set_alpha(green_cell, 0)

	local text 
	print(size)
	if size > 30 then text = "vag_square_cell" else text = "vag_extra_small" end
	local text_node = gui.new_text_node(vmath.vector3(0, 3, 0), utf8.upper(char))
	gui.set_parent(text_node, green_cell)
	gui.set_font(text_node, text)
	gui.set_color(text_node, vmath.vector4(0, 0, 0, 1))
	gui.set_size(text_node,  vmath.vector3(0.1, 0.1, 1))
end

function N.create_ring_cells(letters) 
	local parent_node = gui.get_node("letters_ring")
	local size = 70
	local space = 20
	
	local ring_radius = 135
	local angles = {1.58, 1.58, 0.79, 0, 1.58, 0, 1.58, 0, 1.58, 0, 1.58} 
	local start_angle = angles[#letters]
	local rad_angle_on_circle
	local x, y
	
	for i, char in ipairs(letters) do
		rad_angle_on_circle = ((6.28 / #letters) * i) + start_angle
		x, y = math.getPointOnCircle(ring_radius, rad_angle_on_circle)
		
		local cell = gui.new_box_node(vmath.vector3(x, y, 0), vmath.vector3(size, size, 0))
		gui.set_parent(cell, parent_node)
		gui.set_alpha(cell, 0)

		local white_cell = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
		gui.set_parent(white_cell, cell)
		gui.set_texture(white_cell, "assets")
		gui.play_flipbook(white_cell, "circle_white")
		gui.set_size(white_cell, vmath.vector3(size, size, 0))

		local pink_cell = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
		gui.set_parent(pink_cell, cell)
		gui.set_texture(pink_cell, "assets")
		gui.play_flipbook(pink_cell, "circle_pink")
		gui.set_size(pink_cell, vmath.vector3(size, size, 0))
		gui.set_alpha(pink_cell, 0)
		
		local text_node = gui.new_text_node(vmath.vector3(1, 7, 0), utf8.upper(char))
		gui.set_parent(text_node, cell)
		gui.set_font(text_node, "vag")
		gui.set_color(text_node, vmath.vector4(0, 0, 0, 1))
		gui.set_size(text_node,  vmath.vector3(0.1, 0.1, 1))
	end
end

return N









