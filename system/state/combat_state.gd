class_name CombatState extends State







func _connect_signals() -> void:

	movement_component.move_started.connect(_on_move_started)

	movement_component.move_ended.connect(_on_move_ended)

	movement_component.move_dir_updated.connect(_on_move_dir_updated)



func _disconnect_signals() -> void:

	movement_component.move_started.disconnect(_on_move_started)

	movement_component.move_ended.disconnect(_on_move_ended)

	movement_component.face_dir_updated.connect(_on_move_dir_updated)




func _on_move_started() -> void:

	animation_component.set_body_dir(movement_component.face_dir, true)



func _on_move_ended() -> void:

	animation_component.set_body_dir(movement_component.face_dir, false)



func _on_move_dir_updated(_dir: Vector2) -> void:

	animation_component.set_body_dir(movement_component.face_dir, true)