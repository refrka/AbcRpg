class_name StateMachine extends Node






var active:= true

var current_state: State

var entity: EntityNode







func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	current_state = get_child(0) as State

	for state in get_children():

		state._initialize(entity, self)






func request_state(state_script: Script) -> void:

	for state in get_children():

		if state.get_state_script() == state_script:

			_change_state(state)





func _change_state(state: State) -> void:

	if current_state:

		_deactivate_state(current_state)

	current_state = state

	_activate_state(current_state)





func _activate_state(state: State) -> void:

	state._activate()

	state._enter()




func _deactivate_state(state: State) -> void:

	state._deactivate()

	state._exit()





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