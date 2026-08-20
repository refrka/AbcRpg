class_name MovingState extends State







func _connect_signals() -> void:

	movement_component.move_ended.connect(_on_move_ended)

	movement_component.face_dir_updated.connect(_on_face_dir_updated)



func _disconnect_signals() -> void:

	movement_component.move_ended.disconnect(_on_move_ended)

	movement_component.face_dir_updated.disconnect(_on_face_dir_updated)





func _enter() -> void:

	animation_component.set_body_dir(movement_component.face_dir, true)





func _on_move_ended() -> void:

	transition_to(IdleState)



func _on_face_dir_updated(dir: Vector2) -> void:

	animation_component.set_body_dir(dir, true)