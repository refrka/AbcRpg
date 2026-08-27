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



func add_modifier(modifier: Modifier) ->  void:

	modifiers.append(modifier)

	print("added")

	modifier.expired.connect(_on_modifier_expired.bind(modifier))







func get_speed() -> float:

	var base_speed = entity.entity_def.move_speed

	var speed_modifier = _get_total_speed_modifier()

	return base_speed * speed_modifier




func _get_total_velocity_modifier() -> Vector2:

	var total_modifier:= Vector2.ZERO

	for modifier in modifiers:

		if modifier is VelocityModifier:

			total_modifier += modifier.value

	return total_modifier



func _get_total_speed_modifier() -> float:

	var total_modifier:= 1.0

	for modifier in modifiers:

		if modifier is SpeedModifier:

			total_modifier *= modifier.value

	return total_modifier







func _tick_modifiers(delta: float) -> void:

	for modifier in modifiers:

		modifier.tick(delta)





func _on_modifier_expired(modifier: Modifier) -> void:

	print("expired")

	modifiers.erase(modifier)




func _physics_process(delta: float) -> void:

	if !active: return

	var new_move_velocity = current_move_velocity

	_tick_modifiers(delta)

	if move_dir == Vector2.ZERO:

		new_move_velocity = new_move_velocity.move_toward(Vector2.ZERO, delta)

	else:

		new_move_velocity = move_dir * get_speed()

	var velocity_modifier = _get_total_velocity_modifier()

	new_move_velocity += velocity_modifier

	entity.velocity = new_move_velocity

	entity.move_and_slide()





