class_name EntityNode extends PhysicsBody2D



@export var body_sprite: AnimatedSprite2D

@export var body_collision: CollisionShape2D

@export var component_root: Node

@export var state_machine: StateMachine





var active:= false

var initialized:= false









func _initialize() -> bool:

	if initialized: return false

	initialized = true

	for component in component_root.get_children():

		component._initialize(self)

	state_machine._initialize(self)

	return true









func get_component(component_script: Script) -> Component:

	for component in component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null






func is_moving() -> bool:

	return state_machine.current_state is MovingState






func is_in_combat() -> bool:

	var combat_component = get_component(CombatComponent)

	if !combat_component: return false

	return combat_component.is_in_combat()






func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass






func _activate() -> bool:

	if active: return false

	_connect_signals()

	active = true

	for component in component_root.get_children():

		component._activate()

	state_machine._activate()

	return true



func _deactivate() -> bool:

	if !active: return false

	_disconnect_signals()

	active = false

	for component in component_root.get_children():

		component._deactivate()

	state_machine._activate()

	return true
