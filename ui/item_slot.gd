class_name ItemSlot extends UIElement


signal slot_data_updated


var item_data: ItemData




func set_item_data(_item_data: ItemData) -> void:

	item_data = _item_data




func clear() -> void:

	item_data = null




func is_empty() -> bool:

	if item_data == null:

		return true

	if item_data.is_empty():

		return true

	return false





func _connect_item_data() -> void:

	item_data.item_data_updated.connect(_on_item_data_updated)



func _disconnect_item_data() -> void:

	item_data.item_data_updated.disconnect(_on_item_data_updated)




func _on_item_data_updated() -> void:

	slot_data_updated.emit()