class_name Component extends Node




var _initialized:= false

var entity: EntityNode

var active:= false






func initialize(_entity: EntityNode) -> void:

	if _initialized:

		return

	_initialized = true
	
	entity = _entity








func get_component_script() -> Script:

	return self.get_script()





func activate() -> void:

	if active:

		return

	active = true
	
	_connect_signals()





func deactivate() -> void:

	if !active:

		return
	
	_disconnect_signals()

	active = false





func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass