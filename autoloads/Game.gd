extends Node





var last_save_dict:= {}







func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	_load()

	







func start() -> void:

	_save(last_save_dict)



func reset() -> void:

	pass





















func _save(dict: Dictionary) -> void:

	var path = "user://save_data.json"

	var file = FileAccess.open(path, FileAccess.WRITE)

	file.store_string(JSON.stringify(dict, " "))

	file.close()

	last_save_dict = dict




func _load() -> void:

	var path = "user://save_data.json"

	if FileAccess.file_exists(path):

		var file = FileAccess.open(path, FileAccess.READ)

		var json = JSON.new()

		json.parse(file.get_as_text())

		file.close()

		last_save_dict = json.data

	else:

		var template = SaveTemplate.new()

		last_save_dict = template.data