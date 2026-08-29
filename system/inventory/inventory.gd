class_name Inventory extends Resource



@export var item_list: Array[ItemData] = []



@export var size: int








func resize(_size:= -1) -> void:

	if _size == -1:

		_size = size

	while item_list.size() > _size:

		item_list.pop_back()

	while item_list.size() < _size:

		item_list.append(ItemData.new())







func add_item_def(item_def: ItemDef, amount:= 1) -> int:

	var remaining = amount

	for item_data in _get_all_item_data_with(item_def):

		if !item_data.is_empty():

			remaining = item_data.add_amount(remaining)

	if remaining > 0:

		var empty_data = _get_first_empty_data()

		if empty_data:

			empty_data.set_data(item_def, remaining)

			remaining = 0

	return remaining





func remove_item_def(item_def: ItemDef, amount:= 1) -> int:

	var remaining = amount

	for i in range(item_list.size() - 1, -1, -1):

		var item_data = item_list[i]

		if item_data.item_def == item_def:

			remaining = item_data.add_item(item_def, remaining)

	return remaining





func _get_all_item_data_with(item_def: ItemDef, min_count:= 1) -> Array[ItemData]:

	var valid_item_data: Array[ItemData] = []

	for item_data in item_list:

		if item_data.item_def == item_def:

			valid_item_data.append(item_data)

	return valid_item_data




func _get_first_data_with(item_def: ItemDef, ignore_full:= true) -> ItemData:

	for item_data in item_list:

		if item_data.item_def == item_def:

			if ignore_full and item_data.is_full():

				continue

			return item_data

	return null




func _get_first_data_for(item_def: ItemDef, amount:= 1) -> ItemData:

	for i in range(item_list.size() - 1, -1, -1):

		var item_data = item_list[i]

		if item_data.item_def == item_def:

			if item_def.max_stack - item_data.count >= amount:

				return item_data

	return null




func _get_first_empty_data() -> ItemData:

	for item_data in item_list:

		if item_data.is_empty():

			return item_data

	return null






func _collapse_data() -> void:

	var collapsed_inventory:= Inventory.new()

	collapsed_inventory.size = size

	for i in range(item_list.size()):

		var item_data = item_list[i]

		if item_data.is_full():

			collapsed_inventory.item_list.push_back(item_data)

		else:

			var _item_data = collapsed_inventory._get_first_data_with(item_data.item_def)

			if !_item_data:

				collapsed_inventory.item_list.push_back(item_data)

			else:

				while !item_data.is_empty():

					_item_data.merge(item_data)

					if item_data.is_empty():

						break

					_item_data = collapsed_inventory._get_first_data_with(item_data.item_def)

					if !_item_data:

						collapsed_inventory.item_list.push_back(item_data)

						break

	item_list.assign(collapsed_inventory.item_list)

	resize()

			


		



