class_name State extends Node




var active:= false

var initialized:= false

var entity: EntityNode

var state_machine: StateMachine


var movement_component: MovementComponent

var animation_component: AnimationComponent



func get_state_name() -> StringName:

	return name.trim_suffix("State")



func get_state_script() -> Script:

	return get_script()



func transition_to(state_script: Script) -> void:

	state_machine.request_state(state_script)






func _initialize(_entity: EntityNode, _state_machine: StateMachine) -> bool:

	if initialized: return false

	initialized = true

	entity = _entity

	state_machine = _state_machine

	movement_component = entity.get_component(MovementComponent)

	animation_component = entity.get_component(AnimationComponent)

	return true




func _reset() -> bool:

	if !initialized: return false

	_deactivate()

	initialized = false

	entity = null

	return true




func _enter() -> void:

	pass




func _exit() -> void:

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


