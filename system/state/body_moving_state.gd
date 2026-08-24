class_name BodyMovingState extends BodyState







func _connect_signals() -> void:

	movement_component.move_ended.connect(_on_move_ended)

	movement_component.move_dir_updated.connect(_on_move_dir_updated)

	movement_component.face_dir_updated.connect(_on_face_dir_updated)



func _disconnect_signals() -> void:

	movement_component.move_ended.disconnect(_on_move_ended)

	movement_component.move_dir_updated.disconnect(_on_move_dir_updated)

	movement_component.face_dir_updated.disconnect(_on_face_dir_updated)





func _enter() -> void:

	super()

	movement_component.update_dir()

	movement_component.set_face_dir(movement_component.move_dir)

	animation_component.set_body_dir(movement_component.move_dir, true)



func _exit() -> void:

	super()

	if entity is Player:

		print("exit moving")





func _on_move_ended() -> void:

	transition_to(BodyIdleState)



func _on_face_dir_updated(dir: Vector2) -> void:

	animation_component.set_body_dir(dir, true)




func _on_move_dir_updated(dir: Vector2) -> void:

	if dir == Vector2.ZERO:

		animation_component.set_body_dir(movement_component.face_dir, true)

	else:

		movement_component.set_face_dir(dir)

		animation_component.set_body_dir(dir, true)

