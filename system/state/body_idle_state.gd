class_name BodyIdleState extends BodyState








func _connect_signals() -> void:

	movement_component.move_started.connect(_on_move_started)



func _disconnect_signals() -> void:

	movement_component.move_started.disconnect(_on_move_started)





func _enter() -> void:

	if movement_component.is_moving():

		transition_to(BodyMovingState)

		return

	animation_component.set_body_dir(movement_component.face_dir, false)






func _on_move_started() -> void:

	transition_to(BodyMovingState)
	

