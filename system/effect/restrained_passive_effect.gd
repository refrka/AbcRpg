class_name RestrainedPassiveEffect extends PassiveEffect



var movement_component: MovementComponent





func _apply_effect(_target_entity: EntityNode) -> void:

	super(_target_entity)

	_target_entity.state_machine.request_state(BodyIdleState)	

	movement_component = _target_entity.get_component(MovementComponent)

	movement_component.can_move = false
	



func _stop() -> void:

	movement_component.can_move = true