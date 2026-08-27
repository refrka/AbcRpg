class_name RetreatPreservationBehavior extends PreservationBehavior


@export var retreat_distance:= 500.0


func evaluate(disposition: Disposition = null) -> float:

	var score = super(disposition)

	if !disposition and !last_evaluated_disposition:

		return 0.0

	var distance = last_evaluated_disposition.target_entity.global_position.distance_squared_to(entity.global_position)

	if distance > retreat_distance * retreat_distance:

		return 0.0

	return score