@abstract class_name AmbientBehavior extends Behavior









func _evaluate(_target_disposition: Disposition = null) -> float:

	var score = super(_target_disposition)

	if IsHealthCriticalCondition.run({"entity_node": entity}):

		score = 0.0

	return score