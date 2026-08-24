class_name Inventory extends Resource






@export var size:= 9

var slots: Array[ItemSlot]

var weapon_slot: EquipmentSlot


var initialized:= false






func _initialize() -> bool:

	if initialized: return false

	initialized = true

	if !weapon_slot:

		weapon_slot = EquipmentSlot.new()

		weapon_slot.equipment_type = EquipmentDef.EquipmentType.WEAPON

	_resize()

	return true






func _reset() -> void:

	slots.clear()

	weapon_slot.clear()







func _resize() -> void:

	while slots.size() > size:

		slots.pop_back()

	while slots.size() < size:

		slots.append(ItemSlot.new())