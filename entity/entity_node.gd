class_name EntityNode extends PhysicsBody2D




@export var entity_def: EntityDef

@export var body_sprite: AnimatedSprite2D

@export var body_collision: CollisionShape2D

@export var component_root: Node

@export var state_machine: StateMachine





var active:= false

var initialized:= false

var inventory: Inventory







func _initialize() -> bool:

	assert(entity_def != null, "Initializing undefined entity: %s" % self.name)

	if initialized: return false

	initialized = true

	if entity_def.initial_inventory:

		inventory = entity_def.initial_inventory.duplicate(true)

		inventory._initialize()

	for component in component_root.get_children():

		component._initialize(self)

	state_machine._initialize(self)

	return true






func _reset() -> void:

	if active: _deactivate()

	initialized = false

	for component in component_root.get_children():

		component._reset()

	state_machine._reset()

	inventory._reset()








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
