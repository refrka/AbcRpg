class_name ItemNode extends ObjectNode


@export var item_data: ItemData

@export var item_sprite: Sprite2D






func _initialize() -> bool:

	if !super(): return false

	if item_data:

		load_item_data(item_data)
		
	return true






func load_item_data(_item_data: ItemData) -> void:

	item_data = _item_data

	item_data.item_data_updated.connect(_on_item_data_updated)

	item_sprite.texture = item_data.item_def.icon_texture

	item_sprite.position.y = -item_sprite.texture.get_size().y / 2




func _on_item_data_updated() -> void:

	if item_data.is_empty():

		queue_free.call_deferred()





static func create_new(_item_data: ItemData) -> ItemNode:

	var item_node = load("res://entity/item_node.tscn").instantiate()

	item_node.item_data = _item_data

	return item_node