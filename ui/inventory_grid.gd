class_name InventoryGrid extends UIElement


@export var inventory_grid_space_scene: PackedScene

@export var grid: GridContainer



var item_slots: Array[ItemSlot]






func _initialize() -> bool:

	if !super(): return false

	for child in grid.get_children():

		child._initialize()

	return true





func load_inventory(inventory: Inventory) -> void:

	resize(inventory.size)

	for i in range(inventory.item_list.size()):

		if i > inventory.size: break

		var item_slot = item_slots[i]

		var item_data = inventory.item_list[i]

		item_slot.set_item_data(item_data)




func resize(grid_size: int) -> void:

	var child_count = grid.get_children().size()

	while child_count > grid_size:

		var child = grid.get_child(grid.get_children().size() - 1)

		grid.remove_child(child)

		child.queue_free()

		child_count -= 1
	
	while child_count < grid_size:

		var child = inventory_grid_space_scene.instantiate()

		grid.add_child(child)

		child._initialize()

		child._deactivate()

		child_count += 1

	item_slots.clear()

	item_slots.resize(grid_size)

	for i in range(grid_size):

		item_slots.set(i, grid.get_child(i))



func group_item_slots(group_name: String) -> void:

	for child in grid.get_children():

		child.element_group_name = group_name

		child.add_to_group(group_name)




func _activate() -> bool:

	if !super(): return false

	for child in grid.get_children():

		child._activate()

	return true