class_name ItemData extends Resource


signal item_data_updated



@export var item_def: ItemDef

@export var count: int





func set_data(_item_def: ItemDef, _count: int) -> void:

	item_def = _item_def

	count = _count

	item_data_updated.emit()




func clear() -> void:

	set_data(null, 0)





func add_amount(amount: int) -> int:

	if is_full(): return amount

	var remaining = amount

	var new_count = count

	var space_available = item_def.max_stack - count

	if space_available >= remaining:

		new_count += remaining

		remaining = 0

	else:

		new_count = item_def.max_stack

		remaining -= space_available

	set_data(item_def, new_count)

	return remaining





func remove_amount(amount: int) -> int:

	if is_empty(): return amount

	var remaining = amount

	var new_count = count

	if count >= remaining:

		new_count -= remaining

		remaining = 0

	else:

		new_count = 0

		remaining -= count

	set_data(item_def, new_count)

	return remaining





func can_accept(_item_def: ItemDef, amount:= 1) -> bool:

	if !is_empty():

		if item_def != _item_def:

			return false

		var space_available = item_def.max_stack - count

		if amount > space_available:

			return false

	return true





func is_full() -> bool:

	if is_empty(): return false

	return count >= item_def.max_stack



func is_empty() -> bool:

	return count == 0 or item_def == null