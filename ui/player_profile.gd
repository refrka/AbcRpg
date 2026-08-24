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

	if !inventory:

		inventory = Game.get_player().inventory

		inventory_grid.load_inventory(inventory)

	return true





func _deactivate() -> bool:

	if !super(): return false

	inventory_grid._deactivate()

	return true