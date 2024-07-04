local mmath = require("main.modules.math")
local utf8 = require("main.modules.utf8")
local anim = require "main.modules.animations" --модуль для анимаций

local color_cell_text = vmath.vector4(88 / 255, 89 / 255, 91 / 255, 1)
local color_mini_cell_text = vmath.vector4(77 / 255, 77 / 255, 77 / 255, 1)

local N = {}

function N.create_cell(index, char, word, size, x, y) 
	local parent_node = gui.get_node("words")
	local id =  word .. "_" .. index .. "_" .. char

	local word_cells = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
	gui.set_parent(word_cells, parent_node)
	gui.set_alpha(word_cells, 0)
	gui.set_id(word_cells, word)
	
	local cell = gui.new_box_node(vmath.vector3(x, y, 0), vmath.vector3(size, size, 0))
	gui.set_parent(cell, parent_node)
	gui.set_alpha(cell, 0)
	gui.set_id(cell, id)

	local green_cell = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
	gui.set_parent(green_cell, cell)
	gui.set_texture(green_cell, "assets")
	gui.play_flipbook(green_cell, "cell_green")
	gui.set_size(green_cell, vmath.vector3(size, size, 0))
	gui.set_id(green_cell, id .. "_green")

	local text 

	if size > 30 then text = "vag_square_cell" else text = "vag_extra_small" end
	
	local text_node = gui.new_text_node(vmath.vector3(0, 3, 0), utf8.upper(char))
	gui.set_parent(text_node, green_cell)
	gui.set_font(text_node, text)
	gui.set_color(text_node, vmath.vector4(1, 1, 1, 1))
	gui.set_size(text_node,  vmath.vector3(0.1, 0.1, 1))
	gui.set_id(text_node, id .. "_text")

	local white_cell = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
	gui.set_parent(white_cell, cell)
	gui.set_texture(white_cell, "assets")
	gui.play_flipbook(white_cell, "cell_white")
	gui.set_size(white_cell, vmath.vector3(size, size, 0))
	gui.set_id(white_cell, id .. "_white")

	return white_cell
end

function N.create_ring_cells(letters) 
	local id
	local parent_node = gui.get_node("letters_ring")
	local size = 70
	
	local ring_radius = 135
	local angles = {1.58, 1.58, 0.79, 0, 1.58, 0, 1.58, 0, 1.58, 0, 1.58} 
	local start_angle = angles[#letters]
	local rad_angle_on_circle
	local x, y

	local ring_cells = {}
	
	for i, char in ipairs(letters) do
		rad_angle_on_circle = ((6.28 / #letters) * i) + start_angle
		x, y = mmath.getPointOnCircle(ring_radius, rad_angle_on_circle)
		id = char .. "_" .. i
			
		local cell = gui.new_box_node(vmath.vector3(x, y, 0), vmath.vector3(size, size, 0))
		gui.set_parent(cell, parent_node)
		gui.set_alpha(cell, 0)
		gui.set_id(cell, id)
		table.insert(ring_cells, cell)

		local white_cell = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
		gui.set_parent(white_cell, cell)
		gui.set_texture(white_cell, "assets")
		gui.play_flipbook(white_cell, "circle_white")
		gui.set_size(white_cell, vmath.vector3(size, size, 0))
		gui.set_id(white_cell, id .. "_white")

		local pink_cell = gui.new_box_node(vmath.vector3(0, 0, 0), vmath.vector3(size, size, 0))
		gui.set_parent(pink_cell, cell)
		gui.set_texture(pink_cell, "assets")
		gui.play_flipbook(pink_cell, "circle_pink")
		gui.set_size(pink_cell, vmath.vector3(size, size, 0))
		gui.set_alpha(pink_cell, 0)
		gui.set_id(pink_cell, id .. "_pink")
		
		local text_node = gui.new_text_node(vmath.vector3(1, 7, 0), utf8.upper(char))
		gui.set_parent(text_node, cell)
		gui.set_font(text_node, "vag")
		gui.set_color(text_node, color_cell_text)
		gui.set_size(text_node,  vmath.vector3(0.1, 0.1, 1))
		gui.set_id(text_node, id .. "_text")
	end

	return ring_cells
end

local letter_nodes = {}
local text_nodes = {}

function N.create_interim_letter(letter, number) 
	local size = 30
	local space = 5
	local x = -size + number * (size + space)
	local y = 0
	
	local letters_box = gui.get_node("letters_box")
	local parent_node = gui.get_node("letters")

	gui.animate(parent_node, "position.x", -x / 2, gui.EASING_OUTBACK, 0.3)
	
	local cell = gui.new_box_node(vmath.vector3(x, y, 0), vmath.vector3(size, size, 0))
	gui.set_parent(cell, parent_node)
	gui.set_texture(cell, "assets")
	gui.play_flipbook(cell, "cell_white")
	gui.set_id(cell, "cell_" .. utf8.upper(letter) .. number)

	table.insert(letter_nodes, cell)
	
	local text_node = gui.new_text_node(vmath.vector3(1, 2, 0), utf8.upper(letter))
	gui.set_parent(text_node, cell)
	gui.set_font(text_node, "vag_extra_small")
	gui.set_color(text_node, color_mini_cell_text)
	gui.set_size(text_node,  vmath.vector3(0.1, 0.1, 1))
	gui.set_id(text_node, "letter_" .. utf8.upper(letter) .. number)
	
	table.insert(text_nodes, text_node)
	
	return cell
end

function N.remove_interim_letters() 
	for key, letter_node in pairs(letter_nodes) do
		gui.delete_node(letter_node)
		letter_nodes = {}
		text_nodes = {}
	end
end

return N









