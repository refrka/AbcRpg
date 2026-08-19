class_name EntityNode extends PhysicsBody2D






@onready var component_root:= %ComponentRoot

























func get_component(component_script: Script) -> Component:

	for component in component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null