extends Node



var world_root: Node2D






func _ready() -> void:

	world_root = get_tree().get_first_node_in_group("world_root")