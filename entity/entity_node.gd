class_name EntityNode extends PhysicsBody2D




@onready var body_sprite:= %BodySprite

@onready var body_collision:= %BodyCollision

@onready var component_root:= %ComponentRoot






var active:= false

var initialized:= false








func _initialize() -> bool:

	if initialized: return false

	initialized = true

	for component in component_root.get_children():

		component._initialize(self)

	return true









func get_component(component_script: Script) -> Component:

	for component in component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null








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

	return true



func _deactivate() -> bool:

	if !active: return false

	_disconnect_signals()

	active = false

	for component in component_root.get_children():

		component._deactivate()

	return true
