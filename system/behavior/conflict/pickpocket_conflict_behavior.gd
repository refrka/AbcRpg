class_name PickpicketConflictBehavior extends ConflictBehavior



var pickpocket_complete:= false



func evaluate(disposition: Disposition = null) -> float:

	var score = super(disposition)

	if !disposition and !last_evaluated_disposition:

		return 0.0

	return score






