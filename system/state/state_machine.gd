class_name StateMachine extends Node


signal body_state_changed(new_state: BodyState)

signal combat_state_changed(new_state: CombatState)


@export var initial_body_state: BodyState

@export var initial_combat_state: CombatState

@export var body_root: Node

@export var combat_root: Node


var _initialized:= false

var active:= false

var current_body_state: BodyState

var current_combat_state: CombatState

var _entity: EntityNode







func initialize(entity: EntityNode) -> void:

	if _initialized: 
		
		return

	_initialized	= true

	_entity = entity

	for state in get_all_states():

		state._initialize(entity, self)

	if initial_body_state:

		current_body_state = initial_body_state

	if initial_combat_state:

		current_combat_state = initial_combat_state

	



func request_state(state_script: Script) -> void:

	var state = get_state(state_script)

	if state is BodyState:

		_change_body_state(state)

	elif state is CombatState:

		_change_combat_state(state)





func get_body_states() -> Array[BodyState]:

	var body_states: Array[BodyState] = []

	body_states.assign(body_root.get_children())

	return body_states




func get_combat_states() -> Array[CombatState]:

	var combat_states: Array[CombatState] = []

	combat_states.assign(combat_root.get_children())

	return combat_states



func get_all_states() -> Array[State]:

	var all_states: Array[State] = []

	all_states.append_array(get_body_states())

	all_states.append_array(get_combat_states())

	return all_states




func get_state(state_script: Script) -> State:

	for state in get_all_states():

		if state.get_state_script() == state_script:

			return state

	return null





func activate() -> void:

	active = true

	if current_body_state:

		current_body_state.activate()

	if current_combat_state:

		current_combat_state.activate()



func deactivate() -> void:

	active = false

	if current_body_state:

		current_body_state._deactivate()












func _change_body_state(new_state: State) -> void:

	if new_state == current_body_state:

		if current_body_state.allow_reenter:

			current_body_state._enter()

		return

	if current_body_state:

		current_body_state._exit()

	current_body_state = new_state

	current_body_state._enter()

	body_state_changed.emit(new_state)




func _change_combat_state(new_state: CombatState) -> void:

	if new_state == current_combat_state:

		if current_combat_state.allow_reenter:

			current_combat_state._enter()

		return

	if current_combat_state:

		current_combat_state._exit()

		if current_combat_state.body_state_override and current_body_state is BodyCombatOverrideState:

			request_state(BodyIdleState)

	if new_state.body_state_override:

		request_state(BodyCombatOverrideState)

	current_combat_state = new_state

	current_combat_state._enter()

	combat_state_changed.emit(new_state)













func _physics_process(delta: float) -> void:

	if current_body_state and current_body_state.active:

		current_body_state._tick(delta)

	if current_combat_state and current_combat_state.active:

		current_combat_state._tick(delta)