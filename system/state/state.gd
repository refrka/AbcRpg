class_name State extends Node




var active:= false

var initialized:= false

var entity: EntityNode

var state_machine: StateMachine




func get_state_name() -> StringName:

	return name.trim_suffix("State")



func get_state_script() -> Script:

	return get_script()









func _initialize(_entity: EntityNode, _state_machine: StateMachine) -> bool:

	if initialized: return false

	initialized = true

	entity = _entity

	state_machine = _state_machine

	return true



func _reset() -> bool:

	if !initialized: return false

	_deactivate()

	initialized = false

	entity = null

	return true




func _enter() -> void:

	_update_visuals()




func _exit() -> void:

	pass




func _update_visuals() -> void:

	pass




func _tick(_delta: float) -> void:

	pass





func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass




func _activate() -> void:

	active = true

	_connect_signals()



func _deactivate() -> void:

	active = false

	_disconnect_signals()





