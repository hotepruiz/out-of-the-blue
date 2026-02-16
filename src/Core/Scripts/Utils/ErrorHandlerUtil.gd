extends Node

var ErrorCodes : Dictionary = {}

func _ready():
	var file = FileAccess.open("res://src/Resources/Settings/ErrorCodes.json", FileAccess.READ)
	var json_text = file.get_as_text()
	ErrorCodes = JSON.parse_string(json_text)

func LogWarning(code: String) -> void:
	var error: Dictionary = ErrorCodes.get(code, {})
	
	var stack = get_stack()
	var caller_info := "Origen desconocido"
	
	# 0 = esta función
	# 1 = quien llamó a LogWarning
	if stack.size() > 1:
		var caller = stack[1]
		caller_info = "%s:%s @ %s()" % [
			caller.get("source", "???"),
			str(caller.get("line", "?")),
			caller.get("function", "???")
		]

	var msg := "\nError Source: %s\nErrorCode: %s\nErrorMessage: %s\nErrorReason: %s\n" % [
		caller_info,
		code,
		error.get("Message", "Mensaje no definido"),
		error.get("Reason", "Razón no definida")
	]
	
	push_warning(msg)



func LogError(code: String) -> void:
	var error: Dictionary = ErrorCodes.get(code, {})
	
	var stack = get_stack()
	var caller_info := "Origen desconocido"
	
	# 0 = esta función
	# 1 = quien llamó a LogWarning
	if stack.size() > 1:
		var caller = stack[1]
		caller_info = "%s:%s @ %s()" % [
			caller.get("source", "???"),
			str(caller.get("line", "?")),
			caller.get("function", "???")
		]

	var msg := "\nError Source: %s\nErrorCode: %s\nErrorMessage: %s\nErrorReason: %s\n" % [
		caller_info,
		code,
		error.get("Message", "Mensaje no definido"),
		error.get("Reason", "Razón no definida")
	]
	
	push_error(msg)
