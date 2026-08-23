class_name PickpocketBehavior extends Behavior


@export var target_defs: Array[EntityDef]


var pickpocket_complete:= false




func _evaluate(_data:= {}) -> float:

	super(_data)

	if !data.has("entity_node"):

		return 0.0

	var entity_node = data["entity_node"]

	if !target_defs.has(data["entity_node"].entity_def):

		return 0.0

	target_entity = entity_node

	return 1.0





func _start() -> void:

	super()

	navigation_component.set_target_entity(target_entity)




func _connect_signals() -> void:

	navigation_component.navigation_completed.connect(_on_navigation_completed)

	entity.vision_sensor.entity_exited_sensor.connect(_on_entity_exited_vision_sensor)




func _disconnect_signals() -> void:

	navigation_component.navigation_completed.disconnect(_on_navigation_completed)

	entity.vision_sensor.entity_exited_sensor.disconnect(_on_entity_exited_vision_sensor)





func _on_navigation_completed() -> void:

	var distance = entity.global_position.distance_to(target_entity.global_position)

	if distance <= 32.0:

		target_entity.state_machine.request_state(BodyRestrainedState)





func _on_entity_exited_vision_sensor(entity_node: EntityNode) -> void:

	if entity_node == target_entity:

		target_entity = null

		navigation_component.set_target_entity(null)

		_reevaluate()