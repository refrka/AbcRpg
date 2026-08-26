class_name EntityNode extends PhysicsBody2D




@export var entity_def: EntityDef

@export var _component_root: Node



var active:= false







func initialize() -> void:

	print("erm")

	for component in _component_root.get_children():

		component.initialize(self)

	









func get_component(component_script: Script) -> Component:

	for component in _component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null















func activate() -> void:

	if active: 
		
		return

	active = true

	for component in _component_root.get_children():

		component.activate()





func deactivate() -> void:

	if !active:

		return

	active = false

	for component in _component_root.get_children():

		component.deactivate()