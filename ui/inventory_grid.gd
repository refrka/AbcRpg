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

	pass




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



func group_item_slots(group_name: String) -> void:

	for child in grid.get_children():

		child.element_group_name = group_name

		child.add_to_group(group_name)




func _activate() -> bool:

	if !super(): return false

	for child in grid.get_children():

		child._activate()

	return true