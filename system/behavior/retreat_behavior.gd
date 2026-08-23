class_name RetreatBehavior extends Behavior


@export var retreat_distance:= 300.0








func _evaluate(_target_disposition: Disposition) -> float:

	var baseline = super(_target_disposition)

	if !target_disposition:

		return 0.0

	var evaluation = _get_final_multiplier(baseline)

	return evaluation







func _get_final_multiplier(baseline: float) -> float:

	var final_multiplier = baseline

	var fear_multipler = _get_fear_multiplier()

	return final_multiplier * fear_multipler








func _get_fear_multiplier() -> float:

	var distance = entity.global_position.distance_to(target_disposition.target_entity.global_position)

	if distance >= retreat_distance:

		return 0.0
	
	return super()