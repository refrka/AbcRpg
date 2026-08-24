class_name PlayerProfile extends OverlayElement



@export var inventory_grid: InventoryGrid


var inventory: Inventory



func _initialize() -> bool:

	if !super(): return false

	inventory_grid._initialize()

	inventory_grid.group_item_slots("player_profile_inventory_slot")

	return true





func _activate() -> bool:

	if !super(): return false

	inventory_grid._activate()

	var item_def = load("res://item/consumable/food/apple_def.tres")

	if !inventory:

		inventory = Game.get_player().inventory

		inventory_grid.load_inventory(inventory)

		print(inventory.add_items(item_def, 364))

	else:

		print(inventory.remove_items(item_def, 27))

	return true





func _deactivate() -> bool:

	if !super(): return false

	inventory_grid._deactivate()

	return true