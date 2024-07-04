local L = {}

function L.check_session_id()
	-- Используем JavaScript для чтения значения из localStorage
	local js_code = [[
	(function() {
		var value = localStorage.getItem('sessionId');

		if (value !== null) {
			//console.log('Текущее значение: ' + value);
		} else {
			console.log('Ключ не найден в localStorage.');
		}

		return value;
	})();
	]]

	local result = html5.run(js_code)

	return result
end

return L

