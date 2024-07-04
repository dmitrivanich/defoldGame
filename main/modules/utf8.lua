-- Модуль для работы с русскими символами

local utf8 = {}

local function utf8charbytes(str, i)
	i = i or 1
	local c = str:byte(i)

	if c > 0 and c <= 127 then
		return 1
	elseif c >= 194 and c <= 223 then
		return 2
	elseif c >= 224 and c <= 239 then
		return 3
	elseif c >= 240 and c <= 244 then
		return 4
	end
	return 1
end

function utf8.len(str)
	local len = 0
	local pos = 1
	local bytes = #str
	while pos <= bytes do
		len = len + 1
		pos = pos + utf8charbytes(str, pos)
	end
	return len
end

function utf8.sub(str, start_char, end_char)
	local start_byte = 1
	while start_char > 1 do
		start_byte = start_byte + utf8charbytes(str, start_byte)
		start_char = start_char - 1
	end

	local end_byte = start_byte
	if end_char then
		end_char = end_char - start_char + 1
		while end_char > 0 do
			end_byte = end_byte + utf8charbytes(str, end_byte)
			end_char = end_char - 1
		end
	else
		end_byte = #str + 1
	end

	return str:sub(start_byte, end_byte - 1)
end

-- Таблица сопоставления русских букв в верхнем и нижнем регистрах
local lower_to_upper = {
	["а"] = "А", ["б"] = "Б", ["в"] = "В", ["г"] = "Г",
	["д"] = "Д", ["е"] = "Е", ["ё"] = "Ё", ["ж"] = "Ж",
	["з"] = "З", ["и"] = "И", ["й"] = "Й", ["к"] = "К",
	["л"] = "Л", ["м"] = "М", ["н"] = "Н", ["о"] = "О",
	["п"] = "П", ["р"] = "Р", ["с"] = "С", ["т"] = "Т",
	["у"] = "У", ["ф"] = "Ф", ["х"] = "Х", ["ц"] = "Ц",
	["ч"] = "Ч", ["ш"] = "Ш", ["щ"] = "Щ", ["ъ"] = "Ъ",
	["ы"] = "Ы", ["ь"] = "Ь", ["э"] = "Э", ["ю"] = "Ю", ["я"] = "Я"
}

local upper_to_lower = {}
for k, v in pairs(lower_to_upper) do
	upper_to_lower[v] = k
end

-- Преобразование строки в верхний регистр
function utf8.upper(str)
	local result = ""
	local length = utf8.len(str)
	local i = 1
	while i <= length do
		local char = utf8.sub(str, i, i)
		local upper_char = lower_to_upper[char] or char:upper()
		result = result .. upper_char
		i = i + 1
	end
	return result
end

-- Преобразование строки в нижний регистр
function utf8.lower(str)
	local result = ""
	local length = utf8.len(str)
	local i = 1
	while i <= length do
		local char = utf8.sub(str, i, i)
		local lower_char = upper_to_lower[char] or char:lower()
		result = result .. lower_char
		i = i + 1
	end
	return result
end

return utf8
