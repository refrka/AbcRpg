class_name BodyRestrainedState extends BodyBusyState








func _enter() -> void:

	super()

	animation_component.set_body_dir(movement_component.move_dir, false)

	animation_component.body_anim_player.play("%s/restrained" % entity.entity_def.entity_id)

	entity.state_machine.request_state(CombatRestrainedState)




func _exit() -> void:

	super()

	animation_component.set_body_dir(movement_component.face_dir, false)

	animation_component.body_anim_player.play("RESET")