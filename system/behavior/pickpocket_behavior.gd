class_name PickpocketBehavior extends Behavior


@export var target_defs: Array[EntityDef]


var pickpocket_complete:= false




func _evaluate(_target_disposition: Disposition) -> float:

	var evaluation = super(_target_disposition)

	if target_disposition:

		return evaluation

	return 0.0





func _start() -> void:

	super()

	navigation_component.set_target_entity(target_disposition.target_entity)








func _connect_signals() -> void:

	navigation_component.navigation_completed.connect(_on_navigation_completed)

	entity.vision_sensor.entity_exited_sensor.connect(_on_entity_exited_vision_sensor)




func _disconnect_signals() -> void:

	navigation_component.navigation_completed.disconnect(_on_navigation_completed)

	entity.vision_sensor.entity_exited_sensor.disconnect(_on_entity_exited_vision_sensor)









func receive_damage_package(damage_package: DamagePackage) -> void:

	if damage_package.source_entity == target_disposition.target_entity:

		pass










func _on_navigation_completed() -> void:

	if !target_disposition.target_entity: return

	var distance = entity.global_position.distance_to(target_disposition.target_entity.global_position)

	if distance <= 32.0:

		target_disposition.target_entity.state_machine.request_state(BodyRestrainedState)





func _on_entity_exited_vision_sensor(entity_node: EntityNode) -> void:

	if entity_node == target_disposition.target_entity:

		target_disposition.target_entity = null

		navigation_component.set_target_entity(null)

		evaluation_requested.emit()