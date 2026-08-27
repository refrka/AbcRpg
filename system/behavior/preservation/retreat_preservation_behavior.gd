class_name RetreatPreservationBehavior extends PreservationBehavior


@export var retreat_distance:= 300.0

var retreat_active:= false

var retreat_from_target_entity: EntityNode








func evaluate(disposition: Disposition = null) -> float:

	var score = super(disposition)

	if retreat_active:

		return 2.0

	if !disposition and !last_evaluated_disposition:

		return 0.0

	var distance = entity.get_distance_to(last_evaluated_disposition.target_entity)

	if distance > retreat_distance:

		return 0.0

	# If we have a current retreat target that is still valid, evaluate against that target instead

	if is_instance_valid(retreat_from_target_entity):

		var current_retreat_disposition = behavior_component.get_disposition(retreat_from_target_entity)

		var current_retreat_score = super(current_retreat_disposition)

		if current_retreat_score > score:

			last_evaluated_disposition = current_retreat_disposition

			return current_retreat_score

	retreat_from_target_entity = last_evaluated_disposition.target_entity

	return score









func start() -> void:

	super()

	retreat_active = true

	navigation_component.navigation_finished.connect(_on_navigation_finished)

	var dir = retreat_from_target_entity.get_direction_to(entity)

	var target_position = entity.global_position + (dir * retreat_distance)

	navigation_component.set_target_position(target_position)





func stop() -> void:

	super()

	navigation_component.navigation_finished.disconnect(_on_navigation_finished)





func _on_navigation_finished() -> void:

	var distance = entity.get_distance_to(last_evaluated_disposition.target_entity)

	if !entity.vision_sensor.entities.has(retreat_from_target_entity) or distance > retreat_distance:

		retreat_active = false

		retreat_from_target_entity = null

		evaluation_requested.emit()

	else:

		var dir = retreat_from_target_entity.get_direction_to(entity)

		var target_position = entity.global_position + (dir * retreat_distance)

		navigation_component.set_target_position(target_position)


