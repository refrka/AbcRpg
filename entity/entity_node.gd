class_name EntityNode extends PhysicsBody2D




@export var entity_def: EntityDef

@export var body_sprite: AnimatedSprite2D

@export var body_collision: CollisionShape2D

@export var component_root: Node

@export var state_machine: StateMachine

@export var body_hurtbox: Hurtbox

@export var combat_hitbox: Hitbox

@export var vision_sensor: Sensor

@export var combat_origin: Node2D





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

	if body_hurtbox:

		body_hurtbox._initialize(self)

	if combat_hitbox:

		combat_hitbox._initialize(self)

	if vision_sensor:

		vision_sensor._initialize(self)

	return true






func _reset() -> void:

	if active: _deactivate()

	initialized = false

	for component in component_root.get_children():

		component._reset()

	state_machine._reset()

	inventory._reset()





func receive_damage_package(damage_package: DamagePackage) -> void:

	for component in component_root.get_children():

		if component.has_method("receive_damage_package"):

			component.receive_damage_package(damage_package)





func get_component(component_script: Script) -> Component:

	for component in component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null






func is_moving() -> bool:

	return state_machine.current_state is BodyMovingState






func is_in_combat() -> bool:

	var combat_component = get_component(CombatComponent)

	if !combat_component: return false

	return combat_component.is_in_combat()






func _connect_signals() -> void:

	var health_component = get_component(HealthComponent)

	if health_component:

		health_component.health_depleted.connect(_on_health_depleted)



func _disconnect_signals() -> void:

	pass






func _activate() -> bool:

	if active: return false

	_connect_signals()

	active = true

	for component in component_root.get_children():

		component._activate()

	if state_machine:

		state_machine._activate()

	if body_hurtbox:

		body_hurtbox._activate()

	if combat_hitbox:

		combat_hitbox._activate()

	if vision_sensor:

		vision_sensor._activate()

	return true



func _deactivate() -> bool:

	if !active: return false

	_disconnect_signals()

	active = false

	for component in component_root.get_children():

		component._deactivate()

	if state_machine:

		state_machine._deactivate()

	if body_hurtbox:

		body_hurtbox._deactivate()

	if combat_hitbox:

		combat_hitbox._deactivate()

	if vision_sensor:

		vision_sensor._deactivate()

	return true








func _on_health_depleted() -> void:

	queue_free.call_deferred()