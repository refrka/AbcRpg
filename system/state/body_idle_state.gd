class_name BodyIdleState extends BodyState



var idle:= false




func _connect_signals() -> void:

	movement_component.move_started.connect(_on_move_started)



func _disconnect_signals() -> void:

	movement_component.move_started.disconnect(_on_move_started)





func _enter() -> void:

	super()

	if movement_component.is_moving():

		transition_to(BodyMovingState)

		return

	idle = true

	animation_component.set_body_dir(movement_component.face_dir, false)




func _exit() -> void:

	super()

	idle = false




func _on_move_started() -> void:

	if idle:

		transition_to(BodyMovingState)
	

