class_name PickpicketConflictBehavior extends ConflictBehavior



var pickpocket_complete:= false


var pickpocket_target: EntityNode



func evaluate(disposition: Disposition = null) -> float:

	var score = super(disposition)

	if !disposition and !last_evaluated_disposition:

		return 0.0

	pickpocket_target = last_evaluated_disposition.target_entity

	if !pickpocket_target.inventory:

		return 0.0

	return score


















func tick(_delta: float) -> void:

	if pickpocket_target and !pickpocket_complete:

		var distance = entity.get_distance_to(pickpocket_target)

		if distance <= 32.0:

			pickpocket_complete = true

		else:

			navigation_component.set_target_position(pickpocket_target.global_position)