class_name Inventory extends Resource






@export var size:= 9

@export var item_list: Array[ItemData]

@export var weapon_data:= EquipmentData.new()


var initialized:= false






func _initialize() -> bool:

	if initialized: return false

	initialized = true

	_resize()

	return true




func _reset() -> void:

	item_list.clear()

	weapon_data = null










func add_items(item_def: ItemDef, count:= 1) -> int:

	var remaining = count

	var item_data = _get_data_with(item_def, true)

	if !item_data:

		item_data = _get_first_empty_data()

	while item_data and remaining > 0:

		if item_data.is_empty():

			item_data.set_data(item_def, 1)

			remaining -= 1

		remaining = item_data.add_amount(remaining)

		if remaining > 0:

			item_data = _get_data_with(item_def, true)

			if !item_data:

				item_data = _get_first_empty_data()

	return remaining






func remove_items(item_def: ItemDef, count:= 1) -> int:

	var remaining = count

	var item_data = _get_data_with(item_def)

	while item_data and remaining > 0:

		remaining = item_data.remove_amount(remaining)

		if remaining > 0:

			item_data = _get_data_with(item_def)

	return remaining





func add_item_data(item_data: ItemData) -> void:

	var item_def = item_data.item_def

	var remaining = add_items(item_data.item_def, item_data.count)

	item_data.set_data(item_def, remaining)




func has_items(item_def: ItemDef, count:= 1) -> bool:

	return true




func get_non_empty_data() -> Array[ItemData]:

	var data_list: Array[ItemData] = []

	for item_data in item_list:

		if !item_data.is_empty():

			data_list.append(item_data)

	return data_list






func _get_data_with(item_def: ItemDef, ignore_full:= false) -> ItemData:

	for i in range(size - 1, 0, -1):

		var item_data = item_list[i]

		if item_data.item_def == item_def and !item_data.is_empty():

			if ignore_full and item_data.is_full():

				continue

			return item_data

	return null








func _get_first_empty_data() -> ItemData:

	for item_data in item_list:

		if item_data.is_empty():

			return item_data

	return null






func _resize() -> void:

	while item_list.size() > size:

		item_list.pop_back()

	while item_list.size() < size:

		item_list.append(ItemData.new())



