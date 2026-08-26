class_name EntityNode extends PhysicsBody2D




@export var entity_def: EntityDef

@export var component_root: Node

@export var state_machine: StateMachine

@export var vision_sensor: Sensor

@export var body_hurtbox: Hurtbox





var active:= false

var active_entity_groups: Array[EntityGroup]





func initialize() -> void:

	active_entity_groups.assign(entity_def.entity_groups)

	for component in component_root.get_children():

		component.initialize(self)

	if vision_sensor:

		vision_sensor.initialize(self)

	if body_hurtbox:

		body_hurtbox.initialize(self)

	if state_machine:

		state_machine.initialize(self)

		








func receive_damage_package(damage_package: DamagePackage) -> void:

	for component in component_root.get_children():

		if component.has_method("receive_damage_package"):

			component.receive_damage_package(damage_package)









func get_component(component_script: Script) -> Component:

	for component in component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null








func activate() -> void:

	if active: 
		
		return

	active = true

	for component in component_root.get_children():

		component.activate()

	if vision_sensor: vision_sensor.activate()

	if body_hurtbox: body_hurtbox.activate()

	if state_machine: state_machine.activate()






func deactivate() -> void:

	if !active:

		return

	active = false

	for component in component_root.get_children():

		component.deactivate()

	if vision_sensor: vision_sensor.deactivate()

	if body_hurtbox: body_hurtbox.deactivate()

	if state_machine: state_machine.deactivate()









func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass