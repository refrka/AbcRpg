class_name Component extends Node






var active:= false

var initialized:= false

var entity: EntityNode








func _initialize(_entity: EntityNode) -> bool:

	if initialized: return false

	initialized = true

	entity = _entity

	return true





func _reset() -> bool:

	if !initialized: return false

	_deactivate()

	initialized = false

	entity = null

	return true 










func get_component_name() -> StringName:

	return name.trim_suffix("Component")



func get_component_script() -> Script:

	return get_script()






func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass






func _activate() -> bool:

	if active: return false

	_connect_signals()

	active = true

	return true




func _deactivate() -> bool:

	if !active: return false

	_disconnect_signals()

	active = false

	return true