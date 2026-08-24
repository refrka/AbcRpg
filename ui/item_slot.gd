class_name ItemSlot extends SelectableUIElement


signal slot_data_updated



@export var item_icon: TextureRect

@export var item_count_label: Label


var item_data: ItemData




func set_item_data(_item_data: ItemData) -> void:

	item_data = _item_data

	item_data.item_data_updated.connect(_on_item_data_updated)

	_update_visuals()




func clear() -> void:

	item_data = null




func is_empty() -> bool:

	if item_data == null:

		return true

	if item_data.is_empty():

		return true

	return false




func _update_visuals() -> void:

	super()

	if !item_data or item_data.is_empty():

		item_icon.texture = null

		item_count_label.text = ""

	else:

		item_icon.texture = item_data.item_def.icon_texture

		item_count_label.text = str(item_data.count)





func _connect_item_data() -> void:

	item_data.item_data_updated.connect(_on_item_data_updated)



func _disconnect_item_data() -> void:

	item_data.item_data_updated.disconnect(_on_item_data_updated)




func _on_item_data_updated() -> void:

	_update_visuals()

	slot_data_updated.emit()



