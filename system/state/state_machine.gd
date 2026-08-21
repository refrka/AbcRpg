class_name StateMachine extends Node



signal body_state_changed(new_state: BodyState)

signal combat_state_changed(combat_state: CombatState)



@export var initial_body_state: BodyState

@export var initial_combat_state: CombatState



var body_state: BodyState

var combat_state: CombatState




var active:= true

var initialized:= false

var current_state: State

var entity: EntityNode







func _initialize(_entity: EntityNode) -> void:

	initialized = true

	entity = _entity

	if initial_body_state:

		body_state = initial_body_state

	if initial_combat_state:

		combat_state = initial_combat_state

	current_state = get_child(0) as State

	for state in get_children():

		state._initialize(entity, self)






func _reset() -> void:
	
	if active: _deactivate()

	initialized = false

	entity = null






func get_body_state() -> BodyState:

	return body_state



func get_combat_state() -> CombatState:

	return combat_state




func request_state(state_script: Script) -> void:

	for state in get_children():

		if state.get_state_script() == state_script:

			if state is BodyState:

				_change_body_state(state)

			elif state is CombatState:

				_change_combat_state(state)




func _change_body_state(state: BodyState) -> void:

	if body_state == state and body_state.allow_reenter:

		body_state._enter()

		return

	if body_state:

		_deactivate_state(body_state)

	body_state = state

	_activate_state(body_state)

	body_state_changed.emit(body_state)




func _change_combat_state(state: CombatState) -> void:

	if combat_state == state and combat_state.allow_reenter:

		combat_state._enter()

		return

	if combat_state:

		_deactivate_state(combat_state)

	combat_state = state

	_activate_state(combat_state)

	combat_state_changed.emit(combat_state)






func _activate_state(state: State) -> void:

	state._activate()

	state._enter()




func _deactivate_state(state: State) -> void:

	state._deactivate()

	state._exit()





func _activate() -> void:

	active = true

	if body_state:

		_activate_state(body_state)

	if combat_state:

		_activate_state(combat_state)





func _deactivate() -> void:

	active = false

	if body_state:

		_deactivate_state(body_state)

	if combat_state:

		_deactivate_state(combat_state)






func _physics_process(delta: float) -> void:

	if current_state and current_state.active:

		current_state._tick(delta)