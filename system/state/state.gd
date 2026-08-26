class_name State extends Node




var active:= false

var entity: EntityNode

var state_machine: StateMachine




func get_state_name() -> StringName:

	return name.trim_suffix("State")



func get_state_script() -> Script:

	return get_script()









func _initialize(_entity: EntityNode, _state_machine: StateMachine) -> void:

	entity = _entity

	state_machine = _state_machine




func _enter() -> void:

	active = true
	
	_connect_signals()




func _exit() -> void:

	_disconnect_signals()

	active = false





func _transition_to(state_script: Script) -> void:

	state_machine.request_state(state_script)





func _connect_signals() -> void:

	pass




func _disconnect_signals() -> void:

	pass



func _tick(_delta: float) -> void:

	pass




func activate() -> void:

	active = true



func deactivate() -> void:

	active = false





