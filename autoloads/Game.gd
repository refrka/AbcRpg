extends Node





var last_save_dict:= {}

var player: Player

var camera: Camera2D



func _ready() -> void:

	camera = get_tree().get_first_node_in_group("game_camera")

	player = get_tree().get_first_node_in_group("player")

	_load()









func start() -> void:

	_save(last_save_dict)



func reset() -> void:

	pass












func get_player() -> Player:

	if !player:

		player = load("res://player/player.tscn").instantiate()

		Scenes.world_root.add_child(player)

	return player



func get_mouse_direction(origin_node: Node2D = null) -> Vector2:

	if !origin_node:

		origin_node = get_player()

	return origin_node.global_position.direction_to(Scenes.world_root.get_global_mouse_position())











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