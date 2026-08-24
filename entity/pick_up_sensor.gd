class_name PickUpSensor extends Sensor








func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	var input_component = entity.get_component(InputComponent)

	if input_component:

		pass

	return true








func _on_body_entered_sensor(body: PhysicsBody2D) -> void:

	super(body)

	if body is ItemNode:

		if entity.inventory:

			var item_data = body.item_data

			entity.inventory.add_item_data(item_data)