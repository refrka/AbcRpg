class_name StateMachine extends Node



@export var initial_state: State


var _initialized:= false

var active:= false

var current_state: State

var _entity: EntityNode







func initialize(entity: EntityNode) -> void:

	if _initialized: 
		
		return

	_initialized	= true

	_entity = entity

	if initial_state:

		current_state = initial_state








func activate() -> void:

	active = true

	if current_state:

		current_state._activate()



func deactivate() -> void:

	active = false

	if current_state:

		current_state._deactivate()












func _change_state(new_state: State) -> void:

	if new_state == current_state:

		if current_state.allow_reenter:

			current_state._enter()

		return

	if current_state:

		current_state._exit()

	current_state = new_state

	current_state._enter()











func _physics_process(delta: float) -> void:

	if current_state and current_state.active:

		current_state._tick(delta)