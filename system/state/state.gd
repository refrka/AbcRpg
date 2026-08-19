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

	_update_visuals()




func _exit() -> void:

	pass




func _update_visuals() -> void:

	pass




func _tick(_delta: float) -> void:

	pass




func _activate() -> void:

	active = true



func _deactivate() -> void:

	active = false





