class_name BodyRestrainedState extends BodyBusyState


signal break_free



var break_free_count:= 0.0

var time_restrained:= 0.0






func _enter() -> void:

	super()

	animation_component.set_body_dir(movement_component.move_dir, false)

	animation_component.body_anim_player.play("%s/restrained" % entity.entity_def.entity_id)

	entity.state_machine.request_state(CombatRestrainedState)







func _exit() -> void:

	super()

	break_free_count = 0.0

	animation_component.body_anim_player.play("RESET")

	entity.state_machine.request_state(CombatReadyState)





func _connect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.break_free_pressed.connect(_on_break_free_pressed)




func _disconnect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.break_free_pressed.disconnect(_on_break_free_pressed)






func _on_break_free_pressed() -> void:

	break_free_count += 0.35

	if break_free_count >= 1.0:

		break_free_count = 0.0

		break_free.emit()




func _tick(delta: float) -> void:

	time_restrained += delta

	if break_free_count > 0.0:

		break_free_count -= delta

		if break_free_count <= 0.0:

			break_free_count = 0.0

