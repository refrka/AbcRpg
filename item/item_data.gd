class_name ItemData extends Resource


signal item_data_updated



@export var item_def: ItemDef

@export var count: int








func set_data(_item_def: ItemDef, _count: int) -> void:

	item_def = _item_def

	count = _count

	item_data_updated.emit()







func add_amount(amount: int) -> int:

	var remaining = amount

	var space_available = item_def.max_stack - count

	var new_count = count

	if remaining <= space_available:

		new_count += remaining

		remaining = 0

	else:

		new_count += space_available

		remaining -= space_available

	set_data(item_def, new_count)

	return remaining









func remove_amount(amount: int) -> int:

	var remaining = amount

	var new_count = count

	if remaining <= count:

		new_count -= remaining

		remaining = 0

	else:

		new_count = 0

		remaining -= count

	set_data(item_def, new_count)

	return remaining




func merge(item_data: ItemData) -> void:

	var remaining = add_amount(item_data.count)

	item_data.set_data(item_def, remaining)





func is_empty() -> bool:

	return !item_def or count == 0




func is_full() -> bool:

	if is_empty():

		return false

	if count < item_def.max_stack:

		return false

	return true