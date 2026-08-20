class_name IdleState extends State








func _connect_signals() -> void:

	movement_component.move_started.connect(_on_move_started)



func _disconnect_signals() -> void:

	movement_component.move_started.disconnect(_on_move_started)





func _enter() -> void:

	animation_component.set_body_dir(movement_component.face_dir, false)






func _on_move_started() -> void:

	transition_to(MovingState)
	

