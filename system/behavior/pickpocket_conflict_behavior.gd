class_name PickpocketConflictBehavior extends ConflictBehavior









func _evaluate(_disposition: Disposition = null) -> float:

	var score = super(_disposition)

	return score





func _start(target_disposition: Disposition = null) -> void:

	super(target_disposition)




func _stop(_target_disposition: Disposition = null) -> void:

	super(_target_disposition)