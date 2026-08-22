class_name BodyBusyState extends BodyState







func _enter() -> void:

	super()

	movement_component.can_move = false





func _exit() -> void:

	super()

	movement_component.can_move = true