class_name Component extends Node



signal activated

signal deactivated



var active:= false

var initialized:= false

var entity: EntityNode








func _initialize(_entity: EntityNode) -> bool:

	if initialized: return false

	print("_initing: ", get_component_name())

	initialized = true

	entity = _entity

	return true




func _reset() -> bool:

	if !initialized: return false

	if active: _deactivate()

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

	if !initialized or active: return false

	_connect_signals()

	active = true

	activated.emit()

	return true




func _deactivate() -> bool:

	if !active: return false

	_disconnect_signals()

	active = false

	deactivated.emit()

	return true