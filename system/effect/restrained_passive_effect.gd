class_name RestrainedPassiveEffect extends PassiveEffect



var movement_component: MovementComponent





func _apply_effect(_entity: EntityNode) -> void:

	super(_entity)

	entity.state_machine.request_state(BodyRestrainedState)
	



func _stop() -> void:

	entity.state_machine.request_state(BodyIdleState)

	