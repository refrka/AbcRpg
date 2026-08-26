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
	
	connect_signals()





func deactivate() -> void:

	if !active:

		return
	
	disconnect_signals()

	active = false





func connect_signals() -> void:

	pass



func disconnect_signals() -> void:

	pass