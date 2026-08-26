class_name MovementComponent extends Component



signal move_started

signal move_ended



var modifiers: Array[Modifier]







var move_dir: Vector2


var current_move_velocity: Vector2





func set_move_dir(dir: Vector2) -> void:

	if dir != move_dir:

		move_dir = dir



func halt() -> void:

	entity.velocity = Vector2.ZERO

	set_move_dir(Vector2.ZERO)




func _physics_process(delta: float) -> void:

	var new_move_velocity = current_move_velocity


	if move_dir == Vector2.ZERO:

		new_move_velocity = new_move_velocity.move_toward(Vector2.ZERO, delta)

	else:

		new_move_velocity = move_dir * entity.entity_def.move_speed


	entity.velocity = new_move_velocity

	entity.move_and_slide()

