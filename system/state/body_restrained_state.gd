class_name BodyRestrainedState extends BodyBusyState








func _enter() -> void:

	super()

	animation_component.set_body_dir(movement_component.move_dir, false)

	entity.state_machine.request_state(CombatRestrainedState)




func _exit() -> void:

	super()

	entity.state_machine.request_state(CombatReadyState)