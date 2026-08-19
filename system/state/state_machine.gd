class_name StateMachine extends Node






var active:= true

var current_state: State

var entity: EntityNode







func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	current_state = get_child(0) as State




func _activate_state(state: State) -> void:

	state._activate()

	state._enter()




func _activate() -> void:

	active = true

	if current_state:

		_activate_state(current_state)





func _deactivate() -> void:

	active = false

	if current_state:

		current_state._deactivate()





func _physics_process(delta: float) -> void:

	if current_state and current_state.active:

		current_state._tick(delta)