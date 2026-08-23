extends Node



var world_root: Node2D






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	world_root = get_tree().get_first_node_in_group("world_root")